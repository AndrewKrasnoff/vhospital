# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_appointment, only: %i[show edit update destroy]

  def index
    @appointments = Appointment.where(patient_id: current_user.id) if current_user.type == 'Patient'
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @appointments = Appointment.where(patient_id: current_user.id, doctor_id: @doctor.id, answer: nil)
    if @appointments.count.positive?
      redirect_to appointments_path, info: 'You already have pending appointment with this doctor'
    else
      @appointment = Appointment.new
    end
  end

  def show; end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to root_path, success: 'Appointment was created successfuly'
    else
      @doctor = Doctor.find(appointment_params[:doctor_id])
      flash.now[:danger] = 'Appointment was not created'
      render :new
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id, :question, :answer)
  end

end
