class AddPosterColumnToMovies < ActiveRecord::Migration[5.0]
  def change
    add_attachment :movies, :poster
  end
end
