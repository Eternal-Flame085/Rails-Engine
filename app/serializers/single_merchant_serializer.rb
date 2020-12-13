class SingleMerchantSerializer
  def self.format_merchant(merchant)
    {
      data: {
        id: merchant.id,
        type: "Merchant",
        attributes: {
          name: merchant.name
        }
      }
    }
  end
end
