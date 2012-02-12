class CreateOpinions < ActiveRecord::Migration
  def change
    create_table(:opinions) do |t|
      t.references :book
      t.references :user
      t.text :title, :default => "", :null => false
      t.text :text, :default => "", :null => false
      t.timestamps
    end
  end
end
