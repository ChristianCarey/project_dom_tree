class TagAttributes

  attr_reader :hash
  def initialize(tag_string)
    @hash = parse(tag_string)
  end

  def parse(string)
    tag_type = string.match(/(?<=^<)(\w+)/).to_s
    # raise ParsingError unless tag_type && !tag_type.empty?
    hash = {type:tag_type}

    attribute_names = string.scan(/(\w+)(?==['"])/)
    attribute_values = string.scan(/['"]([\w+\s]*)['"]/)
    attribute_names.each_with_index do |name, index|
      attribute_name = name[0].to_sym
      attribute_value = attribute_values[index][0]
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
