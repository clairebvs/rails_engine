class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customer_by_transaction(merchant)
    select("customers.*, count(transactions.id) as amount")
    .joins(:invoices, :transactions, :merchants)
    .merge(Transaction.successful)
    .where(merchants: {id: merchant})
    .group(:id)
    .limit(1)
    .first
  end
end
