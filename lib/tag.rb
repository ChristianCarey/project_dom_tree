class Tag
  attr_accessor :attributes, :parent, :children, :void

  VOID_ELEMENTS = "area, base, br, col, command, embed, hr, img, input, keygen, link, meta, param, source, track, wbr".split(', ')

  def initialize(tag_string)
    @attributes = TagAttributes.new(tag_string).hash
    @children = []
    @void = VOID_ELEMENTS.include?(attributes[:type])
  end

  def add_child(tag)
    @children.push(tag)
    tag.parent = self
  end

end
