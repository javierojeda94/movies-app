require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password).on(:create) }
  end

  context 'Associations' do
    it { should have_many(:rents) }
    it { should have_many(:movies).through(:rents) }
  end
end