# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :info
 

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_back fallback_location: root_path
  end

 
end
