class RentsController < ApplicationController
  before_action :authenticate_user!
  def show_my_rents
    @rents = Rent.where(user_id:current_user.id).group(:movie).count
  end
end
