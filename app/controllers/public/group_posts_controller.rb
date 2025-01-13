class Public::GroupPostsController < ApplicationController

  def new
  end
  
  def index
    @group_post = GroupPost.new
    @group_posts = GroupPost.page(params[:page])
  end

  def create
    @group = Group.find(params[:group_id])
    @group_post = GroupPost.new(group_post_params)
    @group_user = GroupUser.find_by(group_id: @group.id, user_id: current_user.id)
    @group_post.group_user_id = @group_user.id
    @group_post.group_id = @group.id
    if @group_post.save
      redirect_to group_group_post_path(group_id: @group_post.group_id, id: @group_post)
    else
      render :index
    end
  end

  def show
    @group_post = GroupPost.find(params[:id])
  end

  def edit
    @group_post = GroupPost.find(params[:id])
  end

  def update
    @group_post = GroupPost.find(params[:id])
    if @group_post.save
      redirect_to group_group_post_path(group_id: @group_post.group.id, id: @group_post)
    else
      render :edit
    end
  end

  def destroy
    group_post = GroupPost.find(params[:id])
    group_post.destroy
    redirect_to group_group_posts_path(group_post.group.id)
  end

  private

  def group_post_params
    params.require(:group_post).permit(:user_id, :title, :body, :image)
  end


end
