# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_doctor, only: %i[update edit]

  def index
    @doctors = Doctor.includes(:category).order('categories.name', :email)
  end

  def edit
    @categories = cateories_list(@doctor)
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to doctors_path, success: I18n.t('flash_messages.categories.updated')
    else
      flash.now[:danger] = I18n.t('flash_messages.categories.not_updated')
      render :edit
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:category_id)
  end

  def cateories_list(doctor)
    if doctor.category.present?
      Category.where("id != #{@doctor.category.id}").order(:name)
    else
      Category.all
    end
  end
end
