require 'rails_helper'

RSpec.describe MoviesController, type: :controller do

  it { should use_before_action(:authenticate_user!) }

  describe 'Routes' do
    describe 'GET #index' do
      it { should route(:get, '/movies').to(action: :index) }
      
      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          get :index
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { get :index }
        it { should respond_with(302) }
      end
    end

    describe 'GET #show' do
      let(:movie) { FactoryGirl.create(:movie) }
      it { should route(:get, "/movies/#{movie.id}").to(action: :show, id: movie.id) }
      it { should use_before_action(:set_movie) }

      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          get :show, params: { id: movie.id }
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { get :show, params: { id: movie.id } }
        it { should respond_with(302) }
      end
    end

    describe 'GET #new' do
      it { should route(:get, '/movies/new').to(action: :new) }
      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          get :new
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { get :new }
        it { should respond_with(302) }
      end
    end

    describe 'GET #edit' do
      let(:movie) { FactoryGirl.create(:movie) }
      it { should route(:get, "/movies/#{movie.id}/edit").to(action: :edit, id: movie.id) }
      it { should use_before_action(:set_movie) }

      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          get :edit, params: { id: movie.id }
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { get :edit, params: { id: movie.id } }
        it { should respond_with(302) }
      end
    end

    describe 'POST #create' do
      let(:movie_params) { FactoryGirl.attributes_for(:movie) }
      it { should route(:post, '/movies').to(action: :create) }
      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          post :create, params: { movie: movie_params}
        end
        it { should respond_with(302) }
        it 'creates a movie' do
          expect{ post :create, params: { movie: movie_params } }.to change(Movie, :count).by(1)
        end
      end

      context 'Not Logged In' do
        before { post :create, params: { movie: movie_params} }
        it { should respond_with(302) }
      end
    end

    describe 'PATCH #update' do
      let(:movie) { FactoryGirl.create(:movie) }
      let(:movie_attributes) { FactoryGirl.attributes_for(:movie) }
      it { should route(:put, "/movies/#{movie.id}").to(action: :update, id: movie.id) }
      it { should use_before_action(:set_movie) }

      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          movie_attributes[:name] = 'new name'
          put :update, params: { movie: movie_attributes, id: movie.id }
          movie.reload
        end
        it { should respond_with(302) }
        it { expect(movie.name).to eql movie_attributes[:name] }
      end

      context 'Not Logged In' do
        before { put :update, params: { movie: movie_attributes, id: movie.id } }
        it { should respond_with(302) }
      end  
    end

    describe 'DELETE #destroy' do
      before(:each) do 
        @movie = Movie.create(FactoryGirl.attributes_for(:movie))
      end
      it { should route(:delete, "/movies/#{@movie.id}").to(action: :destroy, id: @movie.id) }
      it { should use_before_action(:set_movie) }

      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
        end
        it 'respond correctly' do 
          delete :destroy, params: { id: @movie.id } 
          expect(response).to have_http_status(302)
        end
        it 'destroy a movie' do
          expect { delete :destroy, params: { id: @movie.id } }.to change(Movie, :count).by(-1)
        end
      end

      context 'Not Logged In' do
        before { delete :destroy, params: { id: @movie.id }  }
        it { should respond_with(302) }
      end  
    end

    describe 'GET #make_a_rent' do
      it { should route(:get, "/rent_a_movie").to(action: :make_a_rent) }
      
      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          get :make_a_rent, xhr: true
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { get :make_a_rent, xhr: true }
        it { should respond_with(401) }
      end
    end

    describe 'POST #create_a_rent' do
      let(:movie) { FactoryGirl.create(:movie) }

      it { should route(:post, "/rent_a_movie").to(action: :create_a_rent) }
      it { should use_before_action(:set_movie) }
      
      context 'Logged In' do
        before do
          user = FactoryGirl.create(:user)
          sign_in user
          post :make_a_rent, params: { id: movie.id }, xhr: true
        end
        it { should respond_with(200) }
      end

      context 'Not Logged In' do
        before { post :make_a_rent, params: { id: movie.id }, xhr: true }
        it { should respond_with(401) }
      end
    end
  end
end