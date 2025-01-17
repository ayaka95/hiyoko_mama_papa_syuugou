class Public::GroupCommentsController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    group_post = GroupPost.find(params[:group_post_id])
    group_comment = GroupComment.new(group_comment_params)
    group_user = GroupUser.find_by(group_id: group.id, user_id: current_user.id)
    group_comment.group_user_id = group_user.id
    group_comment.save
    redirect_to group_group_post_path(group_id: group_post.group.id, id: group_post)
  end

  def destroy
    group_comment = GroupComment.find(params[:id])
    group_comment.destroy
    redirect_to request.referer
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:group_comment, :group_post_id, :group_id)
  end


end
