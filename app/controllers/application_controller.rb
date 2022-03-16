class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:phone, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:phone, :email, :password, :current_password) }
  end

end
