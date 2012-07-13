class RenameColumnToUser < ActiveRecord::Migration
  def self.up
     rename_column :users, :encrypt_password, :encrypted_password
  end

  def self.down
    rename_column :users, :encrypted_password, :encrypt_password
  end
end
