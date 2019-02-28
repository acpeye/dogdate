class AddRatingsToDog < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :rating, :integer
    add_column :dogs, :ratings, :integer, array: true, default: []
  end
end
