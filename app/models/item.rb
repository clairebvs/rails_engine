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

  def self.best_day_for_item(item_id)
    Invoice.select("invoices.*, count(invoice_items.quantity) as total_quantity")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(invoice_items: {item_id: item_id})
    .group("date_trunc('day', invoice_items.created_at), invoices.id")
    .order("total_quantity desc, created_at desc")
    .limit(1)
    .first
    .created_at
  end

end
