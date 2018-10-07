class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.top_items_by_revenue(quantity)
    select("items.*, sum(invoice_items.quantity*invoice_items.unit_price) as item_revenue")
    .joins(:invoice_items, invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("item_revenue DESC")
    .limit(quantity)
  end

  def self.top_items_by_number_sold(quantity)
    select("items.*, count(invoice_items.quantity) as item_sold")
    .joins(:invoice_items, invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("item_sold DESC")
    .limit(quantity)
  end
end
