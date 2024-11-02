class Admin::DashboardsController < ApplicationController

  layout 'admin'
  
  def index
    @users = User.page(params[:page])
  end

end
