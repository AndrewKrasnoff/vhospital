class Category < ApplicationRecord
  has_many :doctors
  validates :name, uniqueness: { case_sensitive: false }
end
