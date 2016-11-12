class TagAttributes
  NAMES = /[\s](\S*?)[=]/
  VALUES = /['"]([\w\s\/,)(#:;\.=-]*)['"]/
  attr_reader :hash

  def initialize(tag_string)
    @hash = parse(tag_string)
  end

  def parse(string)
    check_arguments string => String
    tag_type = string.match(/(?<=^<)(\w+)/).to_s
    hash = {element_type:tag_type}
    attribute_names = string.scan(NAMES).flatten
    attribute_values = string.scan(VALUES) 
    attribute_names.each_with_index do |name, index|
      attribute_name = name.to_sym
      attribute_value = attribute_values[index][0]
      attribute_value = attribute_value.split(' ') if attribute_value.include?(' ')
      hash[attribute_name] = attribute_value
    end
    hash
  end
end

class ParsingError < StandardError
end