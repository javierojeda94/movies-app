require 'rails_helper'

RSpec.describe RentsController, type: :controller do
  
  it { should use_before_action(:authenticate_user!) }

  describe 'Routes' do
    it { should route(:get, '/my_rents').to(action: :show_my_rents) }

    context 'Logged In' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        get :show_my_rents
      end
      it { should respond_with(200) }
    end

    context 'Not Logged In' do
      before { get :show_my_rents }
      it { should respond_with(302) }
    end
  end
end