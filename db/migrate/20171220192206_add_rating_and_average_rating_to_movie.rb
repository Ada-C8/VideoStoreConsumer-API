class AddRatingAndAverageRatingToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :rating, :string
    add_column :movies, :average_rating, :float
  end
end
