require 'rails_helper'

RSpec.describe Rent, type: :model do 
  let(:user) { FactoryGirl.build(:user) }
  let(:movie) { FactoryGirl.build(:movie) }
  context 'Validations' do
    it 'is not valid without user_id' do
      rent = Rent.new(user_id: nil)
      expect(rent).to_not be_valid
    end
    it 'is not valid without movie_id' do 
      rent = Rent.new(movie_id: nil)
      expect(rent).to_not be_valid
    end
    it 'is not valid without rent_date' do 
      rent = Rent.new(rent_date: nil)
      expect(rent).to_not be_valid
    end
    it 'is not valid when the user or movie are not saved' do 
      rent = Rent.new(user_id: user.id, movie_id: movie.id, rent_date: Time.now)
      expect(rent).to_not be_valid
    end
    it 'is valid with all attributes valid' do
      user.save!
      movie.save!
      rent = Rent.new(user_id: user.id, movie_id: movie.id, rent_date: Time.now)
      expect(rent).to be_valid
    end
  end

  context 'Associations' do 
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end
end