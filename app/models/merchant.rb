class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.fetch_items(id)
    Item.where(merchant_id: id)
  end

  def self.find_all_merchant_search(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%")
  end

  def self.find_merchant(attribute, value)
    where("#{attribute} ILIKE ?", "%#{value}%").first
  end

  def self.find_most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.find_most_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .group(:id).where(transactions: {result: "success"})
    .order("items_sold DESC")
    .limit(quantity)
  end
end
