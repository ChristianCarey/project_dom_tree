class DomRenderer
  def render(tag, depth = 0)
    type = tag.attributes[:element_type]
    attributes_string = ""
    tag.attributes.each_with_index do |(key, value), index|
      next if index == 0
      attributes_string += " #{key}=\"#{value}\""
      attributes_string += " " unless index == tag.attributes.length - 1
    end
    indent = "  "
    print indent * depth + "<#{type}#{attributes_string}>"
    tag.children.each do |child|
      puts
      if child.is_a?(Tag)
        render(child, depth+1)
      else
        print indent * (depth + 1) + child
      end
    end

    unless tag.void
      puts
      print indent * depth + "</#{type}>"
    end
  end
end