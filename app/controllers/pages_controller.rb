class PagesController < ApplicationController
  def index
    redirect_to '/movies' if user_signed_in?
  end
end
