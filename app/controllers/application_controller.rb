class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(User) && resource.account_completed == false
      edit_account_path(resource)
    else
      posts_path
    end
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name

  end
end
