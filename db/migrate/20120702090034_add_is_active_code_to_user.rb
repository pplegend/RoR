class AddIsActiveCodeToUser < ActiveRecord::Migration
  def self.up
   add_column :users, :is_active, :boolean, :default=>false
   add_column :users, :active_code, :string
  end

  def self.down
   remove_column :users, :is_active
   remove_column :users, :active_code
  end
end
