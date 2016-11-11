class Dom
  attr_reader :pieces, :root

  TAGS_AND_TEXT_NODES = /(<[\/!]?[\w\s="'-]+>\s*)|([^<>]*)/


  def load(file_path = "./test.html")
    unless file_path[-5..-1] == ".html" || file_path[-4..-1] == ".htm"
      raise ArgumentError.new("Path must point to a .html or .htm file.")
    end
    raise ArgumentError.new("File does not exist.") unless File.file?(file_path)
    @file = File.open(file_path, "r")
    split
  end

  def split
    pieces = @file.read.scan(TAGS_AND_TEXT_NODES).flatten.select { |piece| !piece.nil? } 
    @pieces = pieces.map { |piece| piece.strip }
  end
  # { |piece| !piece.strip.empty? }
  def parse(string)
    raise ArgumentError.new("DOM must be made from a string.") unless string.is_a?(String)
    @pieces = string.scan(TAGS_AND_TEXT_NODES).flatten
  end

  def build
    current_tag = @root = Tag.new("<document>")
    @pieces.each_with_index do |piece, index|
      piece = piece.strip
      next if piece.empty?
      # piece_type = classify(piece)

      # If first tag is not <html>, create an HTML root tag
      # if index == 0
      #   if piece[0..4].downcase == "<html"
      #     @root = current_tag = Tag.new(piece)
      #   else
      #     @root = current_tag = Tag.new("<html>")
      #   end
      # end

      if piece[0..1] == "</" # closing
        # puts "Adding closing #{current_tag}"
        current_tag = current_tag.parent #TODO
      elsif piece[0] == "<" # opening
        # puts "Adding opening: #{current_tag}"
        p "piece: #{piece}"
        p "current_tag: #{current_tag.attributes}"
        puts
        new_tag = Tag.new(piece)
        current_tag.add_child(new_tag)
        current_tag = new_tag
      else # text
        # puts "Adding text #{current_tag}"
        current_tag.children << piece
      end
    end
  end

  def render
    print_line(@root, 0)
    puts
  end

  def print_line(node, depth)
    type = node.attributes[:type]
    indent = "  "
    print indent * depth + "<#{type}>"
    node.children.each do |child|
      puts
      if child.is_a?(Tag)
        print_line(child, depth+1)
      else
        print indent * (depth + 1) + child
      end
    end
    puts
    print indent * depth + "</#{type}>"
  end
end
