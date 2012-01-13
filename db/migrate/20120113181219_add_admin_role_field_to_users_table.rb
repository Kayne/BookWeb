class AddAdminRoleFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :admin, :bool, :default => false
  end
end
