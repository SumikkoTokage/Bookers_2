class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
   	added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
   	devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_in_path_for(resource)
      user_path(current_user)
  end
end
