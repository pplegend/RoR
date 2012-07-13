class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.column :email, :string
      t.column :phone_number, :string
      t.column :ship_to_first_name, :string
      t.column :ship_to_last_name, :string
      t.column :ship_to_address, :string 
      t.column :ship_to_city, :string
      t.column :ship_to_postal_code, :string
      t.column :ship_to_country, :string

      t.column :customer_ip, :string
      t.column :status, :string
      t.column :error_message, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
