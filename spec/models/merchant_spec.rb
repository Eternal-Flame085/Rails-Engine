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

    it ".find_merchant returns a merchant based on the attribute and value given" do
      merchant = create(:merchant, name: 'CDProject Red')
      attribute = 'name'
      value = 'red'

      merchant = Merchant.find_merchant(attribute, value)

      expect(merchant).to be_a Merchant
      expect(merchant.name).to eq('CDProject Red')
    end

    it ".find_all_merchant_seach returns an array of Merchant objects that match the value given" do
      create(:merchant, name: 'CDProject Red')
      create(:merchant, name: 'Red Camera Company')
      create(:merchant, name: 'Just different')
      attribute = 'name'
      value = 'red'

      merchants = Merchant.find_all_merchant_search(attribute, value)

      expect(merchants[0]).to be_a Merchant
      expect(merchants[0].name).to eq('CDProject Red')

      expect(merchants[1]).to be_a Merchant
      expect(merchants[1].name).to eq('Red Camera Company')
    end
  end
end
