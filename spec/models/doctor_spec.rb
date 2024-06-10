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
require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:appointments).dependent(:nullify) }
    it { is_expected.to have_many(:patients).through(:appointments) }
  end
end
