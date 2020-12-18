require 'rails_helper'

describe 'Finders' do
  it "find returns a single merchant record by name" do
    merchant = create(:merchant)
    attribute = 'name'

    get "/api/v1/merchants/find?#{attribute}=#{merchant.name}"

    expect(response).to be_successful

    merchant_call = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_call).to have_key(:data)
    expect(merchant_call[:data]).to be_an(Hash)

    expect(merchant_call[:data]).to have_key(:id)
    expect(merchant_call[:data][:id]).to be_an(String)

    expect(merchant_call[:data]).to have_key(:type)
    expect(merchant_call[:data][:type]).to be_a(String)

    expect(merchant_call[:data]).to have_key(:attributes)
    expect(merchant_call[:data][:attributes]).to be_a(Hash)

    expect(merchant_call[:data][:attributes]).to have_key(:name)
    expect(merchant_call[:data][:attributes][:name]).to be_a(String)
  end

  it "find returns a single merchant record by id" do
    merchant = create(:merchant)
    attribute = 'id'

    get "/api/v1/merchants/find?#{attribute}=#{merchant.id}"

    expect(response).to be_successful

    merchant_call = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_call).to have_key(:data)
    expect(merchant_call[:data]).to be_an(Hash)

    expect(merchant_call[:data]).to have_key(:id)
    expect(merchant_call[:data][:id]).to be_an(String)

    expect(merchant_call[:data]).to have_key(:type)
    expect(merchant_call[:data][:type]).to be_a(String)

    expect(merchant_call[:data]).to have_key(:attributes)
    expect(merchant_call[:data][:attributes]).to be_a(Hash)

    expect(merchant_call[:data][:attributes]).to have_key(:name)
    expect(merchant_call[:data][:attributes][:name]).to be_a(String)
  end

  it "find returns a single merchant record by created_at" do
    merchant = create(:merchant, created_at: '2012-03-27 00:00:00')
    attribute = 'created_at'
    value = '2012-03-27'

    get "/api/v1/merchants/find?#{attribute}=#{value}"

    expect(response).to be_successful

    merchant_call = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_call).to have_key(:data)
    expect(merchant_call[:data]).to be_an(Hash)

    expect(merchant_call[:data]).to have_key(:id)
    expect(merchant_call[:data][:id]).to be_an(String)

    expect(merchant_call[:data]).to have_key(:type)
    expect(merchant_call[:data][:type]).to be_a(String)

    expect(merchant_call[:data]).to have_key(:attributes)
    expect(merchant_call[:data][:attributes]).to be_a(Hash)

    expect(merchant_call[:data][:attributes]).to have_key(:name)
    expect(merchant_call[:data][:attributes][:name]).to be_a(String)
    expect(merchant_call[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "find_all returns all matching merchant records using a name attribute" do
    create(:merchant, name: 'CDProject Red')
    create(:merchant, name: 'Red Camera Company')
    create(:merchant, name: 'Just different')
    attribute = 'name'
    value = 'red'

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data].count).to eq(2)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "find_all returns all matching merchant records using a created_at attribute" do
    create(:merchant, name: 'CDProject Red', created_at: '2012-03-27 00:00:00')
    create(:merchant, name: 'Red Camera Company', created_at: '2012-03-27 23:59:59')
    create(:merchant, name: 'Just different')
    attribute = 'created_at'
    value = '2012-03-27'

    get "/api/v1/merchants/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data].count).to eq(2)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  describe 'Business Intelligence' do
    before :each do
      #companies
      @cdpr = create(:merchant, name: 'CDProject Red')
      ubisoft = create(:merchant, name: 'Ubisoft')
      blizzard = create(:merchant, name: 'Blizzard')
      customer = create(:customer)
      #The games with their values
      cyberpunk = create(:item, name: 'CyberPunk2077', unit_price: 60.0, merchant_id: @cdpr.id)
      wild_hunt = create(:item, name: 'The Witcher: Wild Hunt', unit_price: 30.0, merchant_id: @cdpr.id)
      acv = create(:item, name: 'Assasins Creed: Valhala', unit_price: 60.0, merchant_id: ubisoft.id)
      aco = create(:item, name: 'Assasins Creed: Oddyssey', unit_price: 30.0, merchant_id: ubisoft.id)
      overwatch = create(:item, name: 'Overwatch', unit_price: 60.0, merchant_id: blizzard.id)
      starcraft = create(:item, name: 'Starcraft', unit_price: 30.0, merchant_id: blizzard.id)
      #The invoices
      invoice_1 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: @cdpr.id, created_at: '2012-03-09')
      invoice_2 = create(:invoice, status: 'shipped', customer_id: customer.id, merchant_id: @cdpr.id, created_at: '2013-03-09')
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
    end

    it "most_revenue returns a quantity of merchants sorted by most revenue" do
      quantity = 2
      get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to have_key(:data)
      expect(merchants[:data].count).to eq(2)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
      end

      expect(merchants[:data][0][:attributes][:name]).to eq('CDProject Red')
      expect(merchants[:data][1][:attributes][:name]).to eq('Ubisoft')
    end

    it "most_items_sold returns an array of merchant objects sorted by most items sold" do
      quantity = 2
      get "/api/v1/merchants/most_items?quantity=#{quantity}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants).to have_key(:data)
      expect(merchants[:data].count).to eq(2)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
      end

      expect(merchants[:data][0][:attributes][:name]).to eq('CDProject Red')
      expect(merchants[:data][1][:attributes][:name]).to eq('Ubisoft')
    end

    it "revenue_accross_dates returns a json with total revenue across all merchants between 2 dates" do
      start = '2012-03-09'
      end_date = '2014-03-24'

      get "/api/v1/revenue?start=#{start}&end=#{end_date}"

      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to have_key(:data)

      expect(revenue[:data]).to have_key(:id)
      expect(revenue[:data]).to have_key(:attributes)

      expect(revenue[:data][:attributes]).to have_key(:revenue)
      expect(revenue[:data][:attributes][:revenue]).to eq(11400.0)
    end

    it "merchant_revenue returns " do
      get "/api/v1/merchants/#{@cdpr.id}/revenue"

      expect(response).to be_successful

      revenue = JSON.parse(response.body, symbolize_names: true)

      expect(revenue).to have_key(:data)

      expect(revenue[:data]).to have_key(:id)
      expect(revenue[:data]).to have_key(:attributes)

      expect(revenue[:data][:attributes]).to have_key(:revenue)
      expect(revenue[:data][:attributes][:revenue]).to eq(7800.0)
    end
  end
end
