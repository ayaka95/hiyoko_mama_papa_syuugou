class PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.save
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :post_id)
  end

end