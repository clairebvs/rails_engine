class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :invoices

  validates_presence_of :quantity
  validates_presence_of :unit_price
end
