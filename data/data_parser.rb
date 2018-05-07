module DataParser
  def self.parse(request_data, category, property_name)
    category.nil? ? request_data[property_name] : request_data[category][property_name]
  end
end