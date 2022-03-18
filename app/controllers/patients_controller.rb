# frozen_string_literal: true

class PatientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index
    @patients = Patient.all
  end
end
