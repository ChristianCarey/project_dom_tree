class Tag
  attr_accessor :attributes, :text, :parent, :children

  def initialize(tag_string)
    @attributes = TagAttributes.new(tag_string).hash
  end
end
