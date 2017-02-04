class Movie < ApplicationRecord
  has_many :rents
  has_many :users, through: :rents

  scope :available, -> { where('stock > 0') }
end
