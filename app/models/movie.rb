class Movie < ApplicationRecord
  has_many :rents
  has_many :users, through: :rents

  scope :available, -> { where('stock > 0') }

  has_attached_file :poster, styles: { medium: "200x300#", thumb: "150x200" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/
  validates_attachment_presence :poster
end
