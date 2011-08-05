require 'uri'

class CommentsController < AdminController
  before_filter :authenticate
  
  def index
    page = (params[:page] || '0').to_i
    @comments = Comment.all(
      :order => 'published_on DESC', 
      :skip => page * 10, 
      :limit => 10
    )

    @prev_page = (page - 1).to_s unless page == 0
    @next_page = (page + 1).to_s unless @comments.count < 10

    @allow_comments = ! ENV['commenting_active'].nil?
  end

  def activate
    ENV['commenting_active'] = 'true'
    redirect_to comments_url
  end

  def deactivate
    ENV['commenting_active'] = nil
    redirect_to comments_url
  end

  def hide
    @comment = Comment.find(params[:id])
    @comment.published = false
    @comment.save

    redirect_to(comments_url)
  end

  def publish
    @comment = Comment.find(params[:id])
    @comment.published = true
    @comment.save

    redirect_to(comments_url)
  end

  def show
    @comment = Comment.find(params[:id])

    allRules = similarity_rules(@comment).map do |rule|
      {
        :name => rule[:name],
        :sub => rule[:sub],
        :count => Comment.where(rule[:query]).count,
        :description => describe_rule(rule[:query])
      }
    end
    
    @similarComments = allRules.
      select{ |rule| rule[:count] > 1 }

    render :layout => 'edit'
  end

  def destroy
    comment = Comment.find(params[:id])
    
    similarity_rules(comment).
      reject{|rule| params[rule[:name]].nil?}.
      map{|rule| rule[:query]}.
      each{|query| Comment.where(query).each{|related| related.destroy} }

    comment.destroy

    redirect_to comments_url
  end

  private

  def similarity_rules(comment)
    rules = []

    rules << same_attribute(:name, comment)

    unless comment.email.nil?
      rules << same_attribute(:email, comment)
    end

    unless comment.url.nil?
      rules << same_attribute(:url, comment)
      domain = URI.parse(comment.url).host
      unless domain.nil?
        rules << {:name => :withSameDomain, :query => {:url => /#{Regexp.escape(domain)}/i}, :sub => :withSameUrl}
      end
    end

    rules
  end

  def same_attribute(attribute, object)
    {    
      :name => "withSame#{attribute.to_s.capitalize}".to_sym,
      :query => {attribute => object.read_attribute(attribute)}
    }
  end

  def describe_rule (rule)
    attribute = rule.keys.first.to_s.capitalize
    value = rule.values.first
    if value.is_a?(Regexp)
      "#{attribute} =~ #{value.inspect}"
    else
      "#{attribute} = #{value}"
    end 
  end 

end
