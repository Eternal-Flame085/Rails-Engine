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
    .where(transactions: {result: "success"})
    .group(:id)
    .order("items_sold DESC")
    .limit(quantity)
  end

  def self.total_revenue_across_dates(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {created_at: (start_date)..("#{end_date} 23:59:59"), status: "shipped"})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.total_revenue_for_merchant(merchant_id)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, merchants: {id: merchant_id}, invoices: {status: "shipped"})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
