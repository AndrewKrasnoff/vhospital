# frozen_string_literal: true

class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_appointment, only: %i[show edit update]

  def index
    if current_user.type == 'Patient'
      @appointments = Appointment.where(patient_id: current_user.id).order(answer: :DESC)
    end
    @appointments = Appointment.where(doctor_id: current_user.id).order(answer: :DESC) if current_user.type == 'Doctor'
  end

  def show; end

  def new
    @doctor = Doctor.find(params[:doctor_id])
    if user_active_appointments.positive?
      redirect_to appointments_path, info: I18n.t('flash_messages.appointments.assigned')
    elsif doctor_active_appointments >= 10
      redirect_to category_path(@doctor.category_id),
                  info: I18n.t('flash_messages.appointments.has_ten')
    else
      @appointment = Appointment.new
    end
  end

  def edit
    return if @appointment.answer.nil?

    redirect_to appointment_path(@appointment.id), info: I18n.t('flash_messages.appointments.closed')
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, success: I18n.t('flash_messages.appointments.created')
    else
      @doctor = Doctor.find(appointment_params[:doctor_id])
      flash.now[:danger] = I18n.t('flash_messages.appointments.not_created')
      render :new
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, success: I18n.t('flash_messages.appointments.answer_published')
    else
      flash.now[:danger] = I18n.t('flash_messages.appointments.answwer_not_published')
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

  def user_active_appointments
    Appointment.where(patient_id: current_user.id, doctor_id: @doctor.id, answer: nil).count
  end

  def doctor_active_appointments
    Appointment.where(doctor_id: @doctor.id, answer: nil).count
  end
end
