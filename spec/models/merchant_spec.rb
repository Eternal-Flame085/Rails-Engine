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

    it ".find_most_revenue returns an array of Merchant objects ordered from their revenue" do
      cdpr = create(:merchant, name: 'CDProject Red')
      ubisoft = create(:merchant, name: 'Ubisoft')
      blizzard = create(:merchant, name: 'Blizzard')
      customer = create(:customer)
      #The games with their values
      cyberpunk = create(:item, name: 'CyberPunk2077', unit_price: 60.0, merchant_id: cdpr.id)
      wild_hunt = create(:item, name: 'The Witcher: Wild Hunt', unit_price: 30.0, merchant_id: cdpr.id)
      acv = create(:item, name: 'Assasins Creed: Valhala', unit_price: 60.0, merchant_id: ubisoft.id)
      aco = create(:item, name: 'Assasins Creed: Oddyssey', unit_price: 30.0, merchant_id: ubisoft.id)
      overwatch = create(:item, name: 'Overwatch', unit_price: 60.0, merchant_id: blizzard.id)
      starcraft = create(:item, name: 'Starcraft', unit_price: 30.0, merchant_id: blizzard.id)
      #The invoices
      invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: cdpr.id)
      invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: cdpr.id)
      invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: ubisoft.id)
      invoice_4 = create(:invoice, customer_id: customer.id, merchant_id: ubisoft.id)
      invoice_5 = create(:invoice, customer_id: customer.id, merchant_id: blizzard.id)
      invoice_6 = create(:invoice, customer_id: customer.id, merchant_id: blizzard.id)
      #Invoice_items
      create(:invoice_item, item_id: cyberpunk.id, unit_price: 60.0, invoice_id: invoice_1.id )
      create(:invoice_item, item_id: wild_hunt.id, unit_price: 30.0, invoice_id: invoice_2.id )
      create(:invoice_item, item_id: acv.id, unit_price: 60.0, invoice_id: invoice_3.id )
      create(:invoice_item, item_id: aco.id, unit_price: 30.0, invoice_id: invoice_4.id )
      create(:invoice_item, item_id: overwatch.id, unit_price: 30.0, invoice_id: invoice_5.id )
      create(:invoice_item, item_id: starcraft.id, unit_price: 10.0, invoice_id: invoice_6.id )
      #transactions
      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')
      create(:transaction, invoice_id: invoice_3.id, result: 'success')
      create(:transaction, invoice_id: invoice_4.id, result: 'failed')
      create(:transaction, invoice_id: invoice_5.id, result: 'success')
      create(:transaction, invoice_id: invoice_6.id, result: 'success')

      expect(Merchant.find_most_revenue(2)).to eq([cdpr, ubisoft])
    end

    it ".find_most_items_sold returns an array of Merchant objects ordered by most items sold" do
      cdpr = create(:merchant, name: 'CDProject Red')
      ubisoft = create(:merchant, name: 'Ubisoft')
      blizzard = create(:merchant, name: 'Blizzard')
      customer = create(:customer)
      #The games with their values
      cyberpunk = create(:item, name: 'CyberPunk2077', unit_price: 60.0, merchant_id: cdpr.id)
      wild_hunt = create(:item, name: 'The Witcher: Wild Hunt', unit_price: 30.0, merchant_id: cdpr.id)
      acv = create(:item, name: 'Assasins Creed: Valhala', unit_price: 60.0, merchant_id: ubisoft.id)
      aco = create(:item, name: 'Assasins Creed: Oddyssey', unit_price: 30.0, merchant_id: ubisoft.id)
      overwatch = create(:item, name: 'Overwatch', unit_price: 60.0, merchant_id: blizzard.id)
      starcraft = create(:item, name: 'Starcraft', unit_price: 30.0, merchant_id: blizzard.id)
      #The invoices
      invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: cdpr.id)
      invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: cdpr.id)
      invoice_3 = create(:invoice, customer_id: customer.id, merchant_id: ubisoft.id)
      invoice_4 = create(:invoice, customer_id: customer.id, merchant_id: ubisoft.id)
      invoice_5 = create(:invoice, customer_id: customer.id, merchant_id: blizzard.id)
      invoice_6 = create(:invoice, customer_id: customer.id, merchant_id: blizzard.id)
      #Invoice_items
      create(:invoice_item, item_id: cyberpunk.id, quantity: 100, invoice_id: invoice_1.id )
      create(:invoice_item, item_id: wild_hunt.id, quantity: 50, invoice_id: invoice_2.id )
      create(:invoice_item, item_id: acv.id, quantity: 78, invoice_id: invoice_3.id )
      create(:invoice_item, item_id: aco.id, quantity: 39, invoice_id: invoice_4.id )
      create(:invoice_item, item_id: overwatch.id, quantity: 30, invoice_id: invoice_5.id )
      create(:invoice_item, item_id: starcraft.id, quantity: 10, invoice_id: invoice_6.id )
      #transactions
      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')
      create(:transaction, invoice_id: invoice_3.id, result: 'success')
      create(:transaction, invoice_id: invoice_4.id, result: 'failed')
      create(:transaction, invoice_id: invoice_5.id, result: 'success')
      create(:transaction, invoice_id: invoice_6.id, result: 'success')

      expect(Merchant.find_most_items_sold(2)).to eq([cdpr, ubisoft])
    end

    it ".total_revenue_across_dates returns the total revenue from all merchants within specified dates" do
      #companies
      cdpr = create(:merchant, name: 'CDProject Red')
      ubisoft = create(:merchant, name: 'Ubisoft')
      blizzard = create(:merchant, name: 'Blizzard')
      customer = create(:customer)
      #The games with their values
      cyberpunk = create(:item, name: 'CyberPunk2077', unit_price: 60.0, merchant_id: cdpr.id)
      wild_hunt = create(:item, name: 'The Witcher: Wild Hunt', unit_price: 30.0, merchant_id: cdpr.id)
      acv = create(:item, name: 'Assasins Creed: Valhala', unit_price: 60.0, merchant_id: ubisoft.id)
      aco = create(:item, name: 'Assasins Creed: Oddyssey', unit_price: 30.0, merchant_id: ubisoft.id)
      overwatch = create(:item, name: 'Overwatch', unit_price: 60.0, merchant_id: blizzard.id)
      starcraft = create(:item, name: 'Starcraft', unit_price: 30.0, merchant_id: blizzard.id)
      #The invoices
      invoice_1 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: cdpr.id, created_at: '2012-03-09')
      invoice_2 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: cdpr.id, created_at: '2013-03-09')
      invoice_3 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: ubisoft.id, created_at: '2014-03-09')
      invoice_4 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: ubisoft.id, created_at: '2015-03-09')
      invoice_5 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: blizzard.id, created_at: '2016-03-09')
      invoice_6 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: blizzard.id, created_at: '2017-03-09')
      #Invoice_items
      create(:invoice_item, item_id: cyberpunk.id, quantity: 100, unit_price: 60.0, invoice_id: invoice_1.id )
      create(:invoice_item, item_id: wild_hunt.id, quantity: 60, unit_price: 30.0, invoice_id: invoice_2.id )
      create(:invoice_item, item_id: acv.id, quantity: 60, unit_price: 60.0, invoice_id: invoice_3.id )
      create(:invoice_item, item_id: aco.id, quantity: 30, unit_price: 30.0, invoice_id: invoice_4.id )
      create(:invoice_item, item_id: overwatch.id, quantity: 30, unit_price: 30.0, invoice_id: invoice_5.id )
      create(:invoice_item, item_id: starcraft.id, quantity: 10, unit_price: 10.0, invoice_id: invoice_6.id )
      #transactions
      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')
      create(:transaction, invoice_id: invoice_3.id, result: 'success')
      create(:transaction, invoice_id: invoice_4.id, result: 'failed')
      create(:transaction, invoice_id: invoice_5.id, result: 'success')
      create(:transaction, invoice_id: invoice_6.id, result: 'success')

      start = '2012-03-09'
      end_date = '2014-03-24'

      expect(Merchant.total_revenue_across_dates(start, end_date)).to eq(11400.0)
    end

    it ".totla_revenue_for_merchant returns the total revenue for a specific merchant" do
      cdpr = create(:merchant, name: 'CDProject Red')
      customer = create(:customer)

      cyberpunk = create(:item, name: 'CyberPunk2077', unit_price: 60.0, merchant_id: cdpr.id)
      wild_hunt = create(:item, name: 'The Witcher: Wild Hunt', unit_price: 30.0, merchant_id: cdpr.id)

      invoice_1 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: cdpr.id, created_at: '2012-03-09')
      invoice_2 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: cdpr.id, created_at: '2013-03-09')

      create(:invoice_item, item_id: cyberpunk.id, quantity: 100, unit_price: 60.0, invoice_id: invoice_1.id )
      create(:invoice_item, item_id: wild_hunt.id, quantity: 60, unit_price: 30.0, invoice_id: invoice_2.id )

      create(:transaction, invoice_id: invoice_1.id, result: 'success')
      create(:transaction, invoice_id: invoice_2.id, result: 'success')

      expect(Merchant.total_revenue_for_merchant(cdpr.id)).to eq(7800)
    end
  end
end
