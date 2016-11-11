class TagAttributes

  attr_reader :hash
  def initialize(tag_string)
    @hash = parse(tag_string)
  end

  def parse(string)
    raise ArgumentError.new("Attributes must be made from a string.") unless string.is_a?(String)
    tag_type = string.match(/(?<=^<)(\w+)/).to_s
    hash = {type:tag_type}
    attribute_names = string.scan(/[\s](\S*?)[=]/).flatten
    attribute_values = string.scan(/['"]([\w\s\/;\.=-]*)['"]/) 
    attribute_names.each_with_index do |name, index|
      attribute_name = name.to_sym
      attribute_value = attribute_values[0][0]
      attribute_value = attribute_value.split(' ') if attribute_value.include?(' ')
      hash[attribute_name] = attribute_value
    end
    hash
  end
end

class ParsingError < StandardError
end

# Tag == node
  # attributes hash
  # children array
  # text string
