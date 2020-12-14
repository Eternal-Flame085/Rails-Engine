require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many :items}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'methods' do
    it ".fetch_items returns items that that merchant sells" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      expect(Merchant.fetch_items(merchant.id)[0]).to eq(items[0])
      expect(Merchant.fetch_items(merchant.id)[1]).to eq(items[1])
      expect(Merchant.fetch_items(merchant.id)[2]).to eq(items[2])
    end
  end
end
