class AddHourlyPriceToDog < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :hourly_price, :integer
  end
end
