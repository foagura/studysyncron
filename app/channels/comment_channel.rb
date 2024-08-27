class CommentChannel < ApplicationCable::Channel
  def subscribed
    @post = Post.find(params[:post_id])
    stream_for @post
  end

  def unsubscribed
  end
end
