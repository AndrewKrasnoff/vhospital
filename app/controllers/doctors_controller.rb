# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index
    @doctors = Doctor.all
  end
end
