class Admin::GroupsController < ApplicationController

  layout 'admin'

  def index
    @groups = Group.page(params[:page])
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: 'グループを削除しました'
  end

end
