class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  scope :merchant_id, -> (merchant_id) { where(id: merchant_id)}

  def self.fetch_items(id)
    Item.where(merchant_id: id)
  end

  def self.find_all_merchant_search(attribute, value)
    if  attribute == 'created_at'  || attribute == 'updated_at'
      where(attribute.to_sym => ("#{value} 00:00:00")..("#{value} 23:59:59")).first
    else
      where("#{attribute} ILIKE ?", "%#{value}%")
    end
  end

  def self.find_merchant(attribute, value)
    if attribute == 'id'
      where(attribute.to_sym => value)
    elsif  attribute == 'created_at'  || attribute == 'updated_at'
      where(attribute.to_sym => ("#{value} 00:00:00")..("#{value} 23:59:59")).first
    else
      where("#{attribute} ILIKE ?", "%#{value}%").first
    end
  end

  def self.find_most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.find_most_items_sold(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("items_sold DESC")
    .limit(quantity)
  end

  def self.total_revenue_across_dates(start_date, end_date)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .merge(Invoice.between(start_date, end_date))
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.total_revenue_for_merchant(merchant_id)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .merge(Invoice.shipped)
    .merge(Merchant.merchant_id(merchant_id))
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
