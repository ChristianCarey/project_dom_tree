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
    @pieces = @file.read.scan(TAGS_AND_TEXT_NODES).flatten
  end

  def build
    root = ""
    @pieces.each_with_index do |piece, index|
      tag = Tag.new(piece)
      stack = []
      if index == 0
        if tag.attributes[:type].downcase == "html"
          stack << tag
        else
          stack << Tag.new("<html>")
          stack[0].children << tag
        end
      end
    end



    piece_1 = Tag.new(@pieces[0])
    root_html_tag = ""
    unless piece_1.attributes[:type].downcase == "html"
      root_html_tag = Tag.new("<html>")
    end
    p root_html_tag
  end
  # classify each node as opening, text or closing
    # if opening
    # new Tag (child of current Tag)
    # if text, add to text
    # if closing, change current Tag to current Tag.parent
end
