class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.total_revenue_all_merchants_on_date(date)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
      .sum('quantity * unit_price')
  end

  def self.top_merchants_by_total_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue_merchant")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue_merchant DESC")
    .limit(quantity)
  end

  def self.top_merchants_by_items_sold(quantity)
    select("merchants.*, sum(invoice_items.quantity) as amount")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order('amount DESC')
    .limit(quantity)
  end

  def self.total_revenue_for_a_merchant(merchant_id)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(merchants: {id: merchant_id})
    .sum('quantity*unit_price')
  end

  def self.total_revenue_for_a_merchant_on_date(date, merchant_id)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(merchants: {id: merchant_id})
    .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
    .sum('quantity*unit_price')
  end

  def self.favorite_merchant_for_customer(customer_id)
    select("merchants.*, count(transactions.id) as amount")
    .joins(:invoices, :transactions, :customers)
    .merge(Transaction.successful)
    .where(customers: {id: customer_id})
    .group(:id)
    .order("amount DESC")
    .limit(1)
    .first
  end

end
