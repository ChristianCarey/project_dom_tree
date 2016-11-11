class Dom
  attr_reader :pieces, :root

  TAGS_AND_TEXT_NODES = /(<[\/!]?[\w\s=;\/\.,"'-]+>\s*)|([^<>]*)/


  def load(file_path = "./simple.html")
    unless file_path[-5..-1] == ".html" || file_path[-4..-1] == ".htm"
      raise ArgumentError.new("Path must point to a .html or .htm file.")
    end
    raise ArgumentError.new("File does not exist.") unless File.file?(file_path)
    file = File.open(file_path, "r")
    split(file.read)
  end

  def split(string)
    pieces = string.scan(TAGS_AND_TEXT_NODES).flatten.compact.reject(&:nil?).reject(&:empty?).map(&:strip)
    @pieces = pieces 
  end

  def build
    current_tag = @root = Tag.new("<document>")
    @pieces.each do |piece|
      if piece[0..1] == "</" # closing
        current_tag = current_tag.parent #TODO
      elsif piece[0] == "<" # opening
        new_tag = Tag.new(piece)
        current_tag.add_child(new_tag)
        current_tag = new_tag unless new_tag.void
      else # text
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
    attributes_string = ""
    node.attributes.each_with_index do |(key, value), index|
      next if index == 0
      attributes_string += " #{key}=\"#{value}\""
      attributes_string += " " unless index == node.attributes.length - 1
    end
    indent = "  "
    print indent * depth + "<#{type}#{attributes_string}>"
    node.children.each do |child|
      puts
      if child.is_a?(Tag)
        print_line(child, depth+1)
      else
        print indent * (depth + 1) + child
      end
    end

    unless node.void
      puts
      print indent * depth + "</#{type}>"
    end
  end
end
