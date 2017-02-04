class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :make_a_rent]
  before_action :authenticate_user!
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def rents
    @available_movies = Movie.available
    respond_to do |format|
      format.js
    end
  end

  def make_a_rent
    ran = rand(1..100)
    if ran > 50
      @rent = Rent.new(user_id: current_user.id, movie_id: @movie.id, rent_date: Time.now)
      if @rent.save
        @movie.stock -= 1
        if @movie.save
          @message = '¡The rent is done!'
          @status = 202
        else
          @errors = @movie.errors
        end
      else
        @errors = @rent.errors
      end
    else
      @message = '¡You can not rent now because you have balance to pay'
      @status = 500
      respond_to do |format|
        format.js
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :director, :synopsis, :stock)
    end
end
