class Dom
  attr_reader :pieces, :root

  TAGS_AND_TEXT_NODES = /((?:<\/?[\w]+>)|(?:[\s\w]*))/

  def initialize(file_path = "./simple.html")

  end

  def load(file_path = "./simple.html")
    @file = File.open(file_path, "r")
    split
  end

  def split
    @pieces = @file.read.scan(TAGS_AND_TEXT_NODES).flatten
  end

  def parse(string)
    @pieces = string.scan(TAGS_AND_TEXT_NODES).flatten
  end

  def build
    current_tag = nil
    @pieces.each_with_index do |piece, index|
      next if piece.empty?
      # piece_type = classify(piece)

      # If first tag is not <html>, create an HTML root tag
      if index == 0
        if piece[0..4].downcase == "<html"
          @root = current_tag = Tag.new(piece)
        else
          @root = current_tag = Tag.new("<html>")
        end
      end

      if piece[0..1] == "</" # closing
        puts "Adding closing #{current_tag}"
        current_tag = current_tag.parent #TODO
      elsif piece[0] == "<" # opening
        puts "Adding opening: #{current_tag}"
        new_tag = Tag.new(piece)
        current_tag.add_child(new_tag)
        current_tag = new_tag
      else # text
        puts "Adding text #{current_tag}"
        current_tag.text = piece
      end
    end
  end
end
