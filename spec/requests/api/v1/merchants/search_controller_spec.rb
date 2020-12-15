require 'rails_helper'

describe 'Finders' do
  it "find returns a single merchant record" do
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

  it "find_all returns all matching merchant records using a name attribute" do
    merchant_1 = create(:merchant, name: 'CDProject Red')
    merchants_2 = create(:merchant, name: 'Red Camera Company')
    merchant_3 = create(:merchant, name: 'Just different')
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
end
