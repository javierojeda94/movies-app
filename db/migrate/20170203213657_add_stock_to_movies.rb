class AddStockToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :stock, :integer
  end
end
