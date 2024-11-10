class Public::GroupsController < ApplicationController

  def new
  end

  def create
    group = Group.new
    if group.save
      redirect_to 'index'
    else
      render 'new'
    end
  end

    def index
      @groups = Group.all
      @group = Group.new
    end

    def show
    end

    private

    def group_params
      params.require(:group).permit(:name, :introduction, :image)
    end

end
