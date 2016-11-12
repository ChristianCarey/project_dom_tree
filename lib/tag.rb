class Tag
  attr_accessor :attributes, :parent, :children, :void

  VOID_ELEMENTS = [ "area", "base", "br", "col", "command", "embed", "hr", "img", "input", "keygen", "link", "meta", "param", "source", "track", "wbr"]

  def initialize(tag_string)
    check_arguments tag_string => String
    @attributes = TagAttributes.new(tag_string).hash
    @children = []
    @void = VOID_ELEMENTS.include?(attributes[:element_type])
  end

  def add_child(tag)
    check_arguments tag => Tag
    @children.push(tag)
    tag.parent = self
  end

  def child(index)
    @children[index]
  end
  def first_child
    @children[0]
  end

  def data_attributes
    @attributes.select do |name, value|
      name[0..3] == "data"
    end
  end

  def klass
    @attributes[:class]
  end

  def type
    @attributes[:element_type]
  end

  def attribute_names
    @attributes.keys.drop(1)
  end

  def attribute_values
    @attributes.values.drop(1)
  end
end
