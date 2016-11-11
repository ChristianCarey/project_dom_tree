class TagAttributes

  attr_reader :hash
  def initialize(tag_string)
    @hash = parse(tag_string)
  end

  def parse(string)
    puts string
    check_arguments string => String
    tag_type = string.match(/(?<=^<)(\w+)/).to_s
    hash = {element_type:tag_type}
    attribute_names = string.scan(/[\s](\S*?)[=]/).flatten
    attribute_values = string.scan(/['"]([\w\s\/,)(#:;\.=-]*)['"]/) 
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