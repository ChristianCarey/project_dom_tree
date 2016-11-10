class Tag
  attr_accessor :attributes, :text, :parent, :children, :void

  VOID_ELEMENTS = "area, base, br, col, command, embed, hr, img, input, keygen, link, meta, param, source, track, wbr".split(', ')

  def initialize(tag_string)
    @attributes = TagAttributes.new(tag_string).hash
    @children = []
    @void = VOID_ELEMENTS.include?(attributes[:type])
  end

end
