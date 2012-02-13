class AddTimestampsToBooks < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.timestamps
    end
  end
end
