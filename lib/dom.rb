class Dom
  attr_reader :pieces

  TAGS_AND_TEXT_NODES = /((?:<\/?[\w]+>)|(?:[\s\w]*))/
  

  def load(file_path = "../simple.html")
    @file = File.open(file_path, "r")
  end

  def split
    @pieces = @file.read.scan(TAGS_AND_TEXT_NODES)
  end

  def build
    
  end
  # classify each node as opening, text or closing
    # if opening
    # new Tag (child of current Tag)
    # if text, add to text
    # if closing, change current Tag to current Tag.parent
end