class AddDateAndTimeToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :date, :date
    add_column :dogs, :time, :time
  end
end
