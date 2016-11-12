class DomBuilder
  attr_reader :pieces, :root

  TAGS_AND_TEXT_NODES = /(<[\/!]?[\w\s():=;\/\.#\[\],"'-]+>\s*)|([^<>]*)/


  def load(file_path = "./ny_times.html")
    unless file_path[-5..-1] == ".html" || file_path[-4..-1] == ".htm"
      raise ArgumentError.new("Path must point to a .html or .htm file.")
    end
    raise ArgumentError.new("File does not exist.") unless File.file?(file_path)
    file = File.open(file_path, "r")
    parse(file.read)
  end

  def parse(string)
    matches = string.scan(TAGS_AND_TEXT_NODES)
    @pieces = clean(matches)
    build
  end

  def build
    current_tag = @root = Tag.new("<document>")
    @pieces.each do |piece|
      if piece[0..1] == "</" # closing
        current_tag = current_tag.parent unless current_tag.parent.nil?
      elsif piece[0] == "<" && piece[1] != "!" # opening
        new_tag = Tag.new(piece)
        current_tag.add_child(new_tag)
        current_tag = new_tag unless new_tag.void
      else # text
        current_tag.children << piece
      end
    end
    @root
  end

  
  private

    def clean(matches)
      matches = matches.flatten.compact.map(&:strip)
      matches.reject(&:empty?)
    end
end
