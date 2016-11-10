class Tag
  def parse(string)
    p tag_type = string.match(/(?<=^<)(\w+)/).to_s
    raise ParsingError unless tag_type && !tag_type.empty?
    hash = {type:tag_type}

    p attribute_names = string.scan(/(\w+)(?==['"])/)
    p attribute_values = string.scan(/['"]([\w+\s]*)['"]/)
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
