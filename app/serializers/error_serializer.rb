class ErrorSerializer
  def self.error(error = 'Something wend wrong, check your URL')
    {
      data: {
        id: nil,
        attributes: {
          error: error
        }
      }
    }
  end
end
