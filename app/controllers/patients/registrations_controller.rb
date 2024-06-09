module Patients
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    protect_from_forgery with: :exception

    def create
      params[:user] = params[:user]&.merge(type: 'Patient')
      super
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:phone, :email, :password, :type) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:phone, :email, :password, :current_password) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:phone) }
    end
  end
end
