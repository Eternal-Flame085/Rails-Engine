require 'rails_helper'

describe 'SearchFacade' do
  it ".find items searches for an item with the attribute and value given and returns the item object" do
    item = create(:item, name: 'CyberPunk2077')
    attribute = 'name'
    value = 'punk'
    params = {attribute => value}

    item = SearchFacade.find_item(params)

    expect(item).to be_a Item
    expect(item.name).to eq('CyberPunk2077')
  end

  it ".find_all_items finds all the items that match the value of the attribute given and returns the array of objects" do
    create(:item, name: 'CyberPunk2077')
    create(:item, name: 'CloudPunk')
    create(:item, name: 'Just different')
    attribute = 'name'
    value = 'punk'
    params = {attribute => value}

    items = SearchFacade.find_all_items(params)

    expect(items[0]).to be_a Item
    expect(items[0].name).to eq('CyberPunk2077')

    expect(items[1]).to be_a Item
    expect(items[1].name).to eq('CloudPunk')
  end

  it ".find_all_items find all the items with metching unit_price" do
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 50.0)
    attribute = 'unit_price'
    value = 60.0
    params = {attribute => value}

    items = SearchFacade.find_all_items(params)

    expect(items[0]).to be_a Item
    expect(items[0].unit_price).to eq(value)

    expect(items[1]).to be_a Item
    expect(items[1].unit_price).to eq(value)
  end

  it ".find_item will return one item with matching unit price" do
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 60.0)
    create(:item, unit_price: 50.0)
    attribute = 'unit_price'
    value = 60.0
    params = {attribute => value}

    item = SearchFacade.find_item(params)

    expect(item).to be_a Item
    expect(item.unit_price).to eq(value)
  end

  it ".find_merchant will call the Merchant model and search for a merchant matching the value given" do
    merchant = create(:merchant, name: 'CDProject Red')
    attribute = 'name'
    value = 'red'
    params = {attribute => value}

    merchant = SearchFacade.find_merchant(params)

    expect(merchant).to be_a Merchant
    expect(merchant.name).to eq('CDProject Red')
  end

  it ".find_all_merchants will call the Merchant model and search for a merchants matching the value given" do
    create(:merchant, name: 'CDProject Red')
    create(:merchant, name: 'Red Camera Company')
    create(:merchant, name: 'Just different')
    attribute = 'name'
    value = 'red'
    params = {attribute => value}

    merchants = SearchFacade.find_all_merchants(params)

    expect(merchants[0]).to be_a Merchant
    expect(merchants[0].name).to eq('CDProject Red')

    expect(merchants[1]).to be_a Merchant
    expect(merchants[1].name).to eq('Red Camera Company')
  end
end
