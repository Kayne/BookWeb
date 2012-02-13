class AddRateToOpinions < ActiveRecord::Migration
  def change
    add_column :opinions, :rate, :integer, :default => 1, :null => false
  end
end
