class AddColumnToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :content, :string
  end

  def self.down
    remove_column :categories, :content
  end
end
