class ImageController < ApplicationController
  def create
    @image = Post.find(params[:post_id])
    @image = @post.images.build(params[:comment])
    @post.save()
    redirect_to @post
  end
end
