class Dom
  attr_reader :pieces

  TAGS_AND_TEXT_NODES = /((?:<\/?[\w]+>)|(?:[\s\w]*))/

  def initialize(file_path = "./simple.html")
    load(file_path)
    split
  end

  def load(file_path)
    @file = File.open(file_path, "r")
  end

  def split
    p @pieces = @file.read.scan(TAGS_AND_TEXT_NODES).flatten
  end

  def build
    piece_1 = Tag.new(@pieces[0])
    p piece_1.attributes
  end
  # classify each node as opening, text or closing
    # if opening
    # new Tag (child of current Tag)
    # if text, add to text
    # if closing, change current Tag to current Tag.parent
end
