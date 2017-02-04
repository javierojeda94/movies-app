require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'Routes' do
    it { should route(:get, '/').to(action: :index) }
    
    context 'Logged In' do
      before do
        user = FactoryGirl.create(:user)
        sign_in user
        get :index
      end
      it { should redirect_to(movies_path) }
    end

    context 'Not Logged In' do
      before { get :index }
      it { should_not redirect_to(movies_path) }
    end
  end
end