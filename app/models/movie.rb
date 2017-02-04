class Movie < ApplicationRecord
  has_many :rents, dependent: :restrict_with_error
  has_many :users, through: :rents

  scope :available, -> { where('stock > 0') }

  has_attached_file :poster, styles: { medium: "200x300#", thumb: "150x200" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/
  
  validates_presence_of :name
  validates_presence_of :director
  validates_presence_of :synopsis
  validates_attachment_presence :poster

  validates :stock, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true

end
