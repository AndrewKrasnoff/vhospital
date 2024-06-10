# == Schema Information
#
# Table name: appointments
#
#  id         :bigint           not null, primary key
#  patient_id :integer
#  doctor_id  :integer
#  question   :text
#  answer     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :question, presence: true
  validates :answer, presence: true, if: :should_validate?

  private

  def should_validate?
    !new_record?
  end
end
