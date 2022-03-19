# frozen_string_literal: true

class DoctorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_doctor, only: %i[update edit]
  
  def index
    @doctors = Doctor.includes(:category).order('categories.name', :email)
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to doctors_path, success: "Doctor's category was updated successfuly"
    else
      flash.now[:danger] = 'Category was NOT updated'
      render :edit
    end
  end

  def edit
    @categories = Category.where("id != #{@doctor.category.id}").order(:name)
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:category_id)
  end
end
