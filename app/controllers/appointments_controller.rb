# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_appointment, only: %i[show edit update]

  def index
    @appointments = Appointment.where(patient_id: current_user.id).order(answer: :DESC) if current_user.type == 'Patient'
    @appointments = Appointment.where(doctor_id: current_user.id).order(answer: :DESC) if current_user.type == 'Doctor'
  end

  def show; end

  def edit
    redirect_to appointment_path(@appointment.id), info: 'This Appointment is CLOSED!' unless @appointment.answer.nil?
  end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    @appointment_user_active = Appointment.where(patient_id: current_user.id, doctor_id: @doctor.id, answer: nil).count
    @appointment_doctor_active = Appointment.where(doctor_id: @doctor.id, answer: nil).count
    if @appointment_user_active.positive?
      redirect_to appointments_path, info: 'You already have pending appointment with this doctor'
    elsif @appointment_doctor_active >= 10
      redirect_to category_path(@doctor.category_id),
                  info: 'Doctor already has 10 pending appointments. New appointment is unavaliable'
    else
      @appointment = Appointment.new
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, success: 'Appointment was created successfuly'
    else
      @doctor = Doctor.find(appointment_params[:doctor_id])
      flash.now[:danger] = 'Appointment was not created'
      render :new
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, success: 'The Answer was puplished succesfuly'
    else
      flash.now[:danger] = 'The Answer was NOT puplished'
      render :edit
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    if action_name == 'new' || action_name == 'create'
      params.require(:appointment).permit(:patient_id, :doctor_id, :question)
    else
      params.require(:appointment).permit(:answer)
    end
  end
end
