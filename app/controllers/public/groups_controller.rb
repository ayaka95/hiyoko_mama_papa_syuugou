class Public::GroupsController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def new
  end

  def index
    @groups = Group.page(params[:page])
    @group = Group.new
  end

  def create
    @groups = Group.page(params[:page])
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to group_path(@group.id)
    else
      render 'index'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.delete
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def is_matching_login_user
    @group = Group.find(params[:id])
    unless @group.owner.id == current_user.id
      redirect_to groups_path
    end
  end

end
