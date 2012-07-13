class Order < ActiveRecord::Base
  attr_protected :id, :customer_id, :status, :error_message, :updated_at, :created_at
  attr_accessor :card_type, :card_number, :card_expiration_month, :card_expiration_year, :card_verification_value
  has_many :order_items
  has_many :products, :through=>:order_items
  validates :order_items, :length=>{:minimum=>1}
  validates :ship_to_first_name,:ship_to_last_name,:ship_to_address,:ship_to_city, :ship_to_postal_code,:ship_to_country,:length=>{:in=>2..255}
 
  validates :phone_number, :length=>{:in=>7..20}
  validates :customer_ip, :length=>{:in=>7..15}
  validates :email, :format=>{:with=>/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  #validates :status, :inclusion=>{:in=>%w(open processed closed failed)}
  validates :card_type, :inclusion=>{:in=>['Visa','MasterCard','Discover'], :on=>:create}
  validates :card_number, :length=>{:in=>13..19, :on=>:create}
  validates :card_expiration_month, :inclusion=>{:in=>%w(1 2 3 4 5 6 7 8 9 10 11 12), :on=>:create}
  validates :card_expiration_year, :inclusion=>{:in=>%w(2009 2010 2011 2012), :on=>:create}
  validates :card_verification_value, :length=>{:in=>3..4, :on=>:create}
  def total
   cart_items.inject(0){|sum,n| n.product.price*n.amount + sum}
  end

def process
result = true
#
# TODO Charge the customer by calling the payment gateway
#
self.status = 'processed'
save!
result
end
def purchase
  response = process_purchase
  transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
  cart.update_attribute(:purchased_at, Time.now) if response.success?
  response.success?
end

def express_token=(token)
  write_attribute(:express_token, token)
  if new_record? && !token.blank?
    details = EXPRESS_GATEWAY.details_for(token)
    self.express_payer_id = details.payer_id
    self.first_name = details.params["first_name"]
    self.last_name = details.params["last_name"]
  end
end

private

def process_purchase
  if express_token.blank?
    GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
  else
    EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
  end
end

def standard_purchase_options
  {
    :ip => ip_address,
    :billing_address => {
      :name     => "Ryan Bates",
      :address1 => "123 Main St.",
      :city     => "New York",
      :state    => "NY",
      :country  => "US",
      :zip      => "10001"
    }
  }
end

def express_purchase_options
  {
    :ip => ip_address,
    :token => express_token,
    :payer_id => express_payer_id
  }
end

def validate_card
  if express_token.blank? && !credit_card.valid?
    credit_card.errors.full_messages.each do |message|
      errors.add_to_base message
    end
  end
end
end
