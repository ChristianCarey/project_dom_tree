class DomBuilder
  attr_reader :pieces, :root

  TAGS_AND_TEXT_NODES = /(<[\/!]?[\w\s():=;\/\.,"'-]+>\s*)|([^<>]*)/

  #(<[\/!]?[\w\s=;\/\.,"'-]+>\s*)|([^<>]*)

  def load(file_path = "./simple.html")
    unless file_path[-5..-1] == ".html" || file_path[-4..-1] == ".htm"
      raise ArgumentError.new("Path must point to a .html or .htm file.")
    end
    raise ArgumentError.new("File does not exist.") unless File.file?(file_path)
    file = File.open(file_path, "r")
    parse(file.read)
    build
  end

  def parse(string)
    matches = string.scan(TAGS_AND_TEXT_NODES)
    @pieces = clean(matches)
  end

  def clean(matches)
    matches = matches.flatten.compact.map(&:strip)
    matches.reject(&:empty?)
  end

  def build
    current_tag = @root = Tag.new("<document>")
    @pieces.each do |piece|
      if piece[0..1] == "</" # closing
        current_tag = current_tag.parent unless current_tag.parent.nil? #TODO
      elsif piece[0] == "<" && piece[1] != "!" # opening
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
