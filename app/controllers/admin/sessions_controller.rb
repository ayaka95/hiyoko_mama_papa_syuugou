class Admin::SessionsController < Devise::SessionsController

  layout 'admin'

  protected

  def after_sign_in_path_for(resource)
    admin_dashboards_path
  end

  def after_sign_out_path_for(resouece_or_scope)
    new_admin_session_path
  end

end
