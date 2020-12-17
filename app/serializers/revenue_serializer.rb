class RevenueSerializer
  def self.revenue(total)
    {
      data: {
        id: nil,
        attributes: {
          revenue: total
        }
      }
    }
  end
end
