class Admin::GroupsController < ApplicationController

  layout 'admin'

  def index
    @groups = Group.page(params[:page])
  end

end
