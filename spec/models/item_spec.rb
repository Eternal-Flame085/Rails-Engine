require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe  'methods' do
    it ".fetch_merchant returns the merchant that sells that item" do
      item = create(:item)
      item_merchant = Merchant.find(item.merchant_id)

      expect(Item.fetch_merchant(item.id)).to eq(item_merchant)
    end
  end
end
