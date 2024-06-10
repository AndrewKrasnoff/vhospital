# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  type                :string
#  category_id         :integer
#  phone               :string
#
class Doctor < User
  belongs_to :category
  has_many :appointments, dependent: :nullify
  has_many :patients, through: :appointments
end
