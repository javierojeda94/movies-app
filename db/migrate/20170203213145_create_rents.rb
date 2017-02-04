class CreateRents < ActiveRecord::Migration[5.0]
  def change
    create_table :rents do |t|
      t.belongs_to :user, index: true
      t.belongs_to :movie, index: true
      t.datetime :rent_date

      t.timestamps
    end
  end
end
