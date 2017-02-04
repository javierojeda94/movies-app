require 'rails_helper'

RSpec.describe Movie, type: :model do

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:director) }
    it { should validate_presence_of(:synopsis) }
    it { should validate_presence_of(:stock) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
    it { should validate_attachment_presence(:poster) }
  end

  context 'Instantiation' do
    it { should have_attached_file(:poster) }
    it { should validate_attachment_content_type(:poster).
          allowing('image/png', 'image/gif').rejecting('text/plain', 'text/xml') }
  end

  context 'Associations' do
    it { should have_many(:rents).dependent(:restrict_with_error) }
    it { should have_many(:users).through(:rents) }
  end

  context 'Scope :available' do
    let(:movie) { FactoryGirl.create(:movie) }
    
    it 'should include all movies with stock greater than 0' do
      expect(Movie.available).to include(movie)
    end
    it 'should exclude any movie with stock equal to 0' do
      movie.stock = 0
      movie.save!
      expect(Movie.available).not_to include(movie)
    end
  end
end