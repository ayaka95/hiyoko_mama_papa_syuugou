class Public::GroupUsersController < ApplicationController

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])
    group_user.save
    redirect_to groups_path
  end

 def destroy
 end

end
