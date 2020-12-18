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

    it ".find_item returns an Item based on the attribute and value given" do
      item = create(:item, name: 'CyberPunk2077')
      attribute = 'name'
      value = 'punk'

      item = Item.find_item(attribute, value)

      expect(item).to be_a Item
      expect(item.name).to eq('CyberPunk2077')
    end

    it ".find_all_items_seach returns an array of Item objects that match the value given" do
      create(:item, name: 'CyberPunk2077')
      create(:item, name: 'CloudPunk')
      create(:item, name: 'Just different')
      attribute = 'name'
      value = 'punk'

      items = Item.find_all_items_search(attribute, value)

      expect(items[0]).to be_a Item
      expect(items[0].name).to eq('CyberPunk2077')

      expect(items[1]).to be_a Item
      expect(items[1].name).to eq('CloudPunk')
    end

    it ".find_item will return one item with matching unit price" do
      create(:item, unit_price: 60.0)
      create(:item, unit_price: 60.0)
      value = 60.0

      item = Item.find_item('unit_price', value)

      expect(item).to be_a Item
      expect(item.unit_price).to eq(value)
    end

    it ".find_item will return one item with matching id" do
      item_1 = create(:item)

      item = Item.find_item('id', item_1.id)

      expect(item).to be_a Item
      expect(item.id).to eq(item_1.id)
    end

    it ".find_item will return one item with matching created_at date" do
      item_1 = create(:item, created_at: '2012-03-27')

      item = Item.find_item('created_at', item_1.created_at)

      expect(item).to be_a Item
      expect(item.created_at).to eq(item_1.created_at)
    end

    it ".find_all_items will return one item with matching created_at date" do
      item_1 = create(:item, created_at: '2012-03-27')
      item_2 = create(:item, created_at: '2012-03-27')
      date = '2012-03-27'

      items = Item.find_all_items_search('created_at', date)
      
      expect(items.count).to eq(2)
      expect(items[0].created_at).to eq(item_1.created_at)
      expect(items[1].created_at).to eq(item_2.created_at)
    end

    it ".find_all_items_search returns an array of Items that have a matching unit price" do
      create(:item, unit_price: 60.0)
      create(:item, unit_price: 60.0)
      create(:item, unit_price: 50.0)
      value = 60.00

      items = Item.find_all_items_search('unit_price', value)

      expect(items[0]).to be_a Item
      expect(items[0].unit_price).to eq(value)

      expect(items[1]).to be_a Item
      expect(items[1].unit_price).to eq(value)
    end

  end
end
