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
    .order("amount DESC")
    .limit(1)
    .first
  end

  def self.customers_with_pending_invoices(merchant_id)
  	self.find_by_sql("SELECT customers.* FROM customers
  	INNER JOIN invoices ON customers.id = invoices.customer_id
  	INNER JOIN transactions ON transactions.invoice_id = invoices.id
  	WHERE invoices.merchant_id = #{merchant_id}
  	EXCEPT
  	SELECT customers.* FROM customers
  	INNER JOIN invoices ON customers.id = invoices.customer_id
  	INNER JOIN transactions ON transactions.invoice_id = invoices.id
  	WHERE transactions.result = 'success' AND invoices.merchant_id = #{merchant_id};")
	end
end
