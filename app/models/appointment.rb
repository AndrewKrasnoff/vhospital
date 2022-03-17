class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :question, presence: true
  validates :answer, presence: true, if: :should_validate?

  def should_validate?
    !new_record?
  end
end
