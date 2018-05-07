require 'tic_tac_toe_rz'

module DataParser
  def self.parse(request_data, category, property_name)
    if !category.nil?
      raise TicTacToeRZ::NilReferenceError, "#{property_name} is missing" if !request_data[category].include?(property_name)
      request_data[category][property_name]
    else
      raise TicTacToeRZ::NilReferenceError, "#{property_name} is missing" if !request_data.include?(property_name)
      request_data[property_name]
    end
  end
end