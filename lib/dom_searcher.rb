class DomSearcher
  def find_by_attribute(tag, name, value, found = [])
    check_arguments(tag => Tag, name => Symbol, value => String)
    tag_value = tag.attributes[name]    
    if tag_value.is_an?(Array)
      found << tag if tag_value.include?(value)
    else
      found << tag if tag_value == value
    end
    tag.children.each do |child|
      find_by_attribute(child, name, value, found) if child.is_a?(Tag)
    end
    found
  end

  def find_by_type(tag, type, found = [])
    check_arguments tag => Tag, type => String
    found << tag if tag.type == type
    tag.children.each do |child|
      find_by_type(child, type, found) if child.is_a?(Tag)
    end
    found
  end

  def search_parents(tag, name, value, found = [])
    check_arguments tag => Tag, name => Symbol, value => String
    tag_value = tag.attributes[name]
    if tag_value.is_an?(Array)
      found << tag if tag_value.include?(value)
    else
      found << tag if tag_value == value
    end
    search_parents(tag.parent, name, value, found) if tag.parent
    found
  end

  def tag_stats(tag)
    {
      :children => count_children(tag),
      :children_types => children_types(tag),
      :data_attributes => tag.data_attributes
    }
  end

  def count_children(tag)
    count = 0
    each_child(tag) do |child|
      count+= 1
    end
    count
  end

  def children_types(tag)
    types = Hash.new(0)
    each_child(tag) do |child|
      if child.is_a?(Tag)
        types[child.type] += 1
      else
        types[:text_node] += 1
      end
    end
    types
  end

  def each_child(tag, first=true, &block)
    yield(tag) unless first
    if tag.is_a?(Tag)
      tag.children.each do |child|
        each_child(child, false, &block)
      end
    end
  end
end
  