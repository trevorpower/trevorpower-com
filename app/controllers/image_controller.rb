class ImageController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @image = @post.images.build(params[:file])
    @post.save()
    redirect_to @post
  end
end
