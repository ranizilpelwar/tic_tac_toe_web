module DataParser
  def self.parse(request_data, category, property_name)
    request_data[category][property_name]
  end
end