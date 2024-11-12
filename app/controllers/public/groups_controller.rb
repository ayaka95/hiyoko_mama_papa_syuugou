class Public::GroupsController < ApplicationController

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
      redirect_to groups_path
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

    private

    def group_params
      params.require(:group).permit(:name, :introduction, :image)
    end

end
