class Public::GroupFavoritesController < ApplicationController

  def create
    group = Group.find(params[:group_id])
    group_post = GroupPost.find(params[:group_post_id])
    group_user = GroupUser.find_by(group_id: group.id, user_id: current_user.id)
    group_favorite = GroupFavorite.new(group_id: group.id, group_post_id: group_post.id)
    group_favorite.group_user_id = group_user.id
    group_favorite.save
    redirect_to request.referer
  end

  def destroy
  end


end
