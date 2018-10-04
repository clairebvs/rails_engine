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
end
