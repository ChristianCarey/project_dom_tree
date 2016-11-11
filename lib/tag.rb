class Tag
  attr_accessor :attributes, :parent, :children, :void

  VOID_ELEMENTS = ["area", "base", "br", "col", "command", "embed", "hr", "img", "input", "keygen", "link", "meta", "param", "source", "track", "wbr", "!DOCTYPE html"]

  def initialize(tag_string)
    raise ArgumentError.new("Tag must be created from a string.") unless tag_string.is_a?(String)
    @attributes = TagAttributes.new(tag_string).hash
    @children = []
    @void = VOID_ELEMENTS.include?(attributes[:type])
  end

  def add_child(tag)
    raise ArgumentError.new("Child must be a tag!") unless tag.is_a?(Tag)
    @children.push(tag)
    tag.parent = self
  end

  def type
    @attributes[:type]
  end

end
