require 'rails_helper'

describe 'Finders' do
  it "find returns a single Item record" do
    item = create(:item)
    attribute = 'name'

    get "/api/v1/items/find?#{attribute}=#{item.name}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response).to have_key(:data)
    expect(item_response[:data]).to be_an(Hash)

    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to be_an(String)

    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to be_a(String)

    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to be_a(Hash)

    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to be_a(String)
  end

  it "find_all returns all matching item records using a name attribute" do
    create(:item, name: 'CyberPunk2077')
    create(:item, name: 'CloudPunk')
    create(:item, name: 'Just different')
    attribute = 'name'
    value = 'punk'

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end

  it "find_all returns all matching item records using a description attribute" do
    create(:item, description: 'CyberPunk2077')
    create(:item, description: 'CloudPunk')
    create(:item, description: 'Just different')
    attribute = 'description'
    value = 'punk'

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end

  it "find_all returns all matching item records using a unit_price attribute" do
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 50.0)
    attribute = 'unit_price'
    value = 60.0

    get "/api/v1/items/find_all?#{attribute}=#{value}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)
    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end
  end
end
