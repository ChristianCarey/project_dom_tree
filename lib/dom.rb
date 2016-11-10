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

  def classify(piece)
    case piece
    when piece[0..1] == "</"
      return :closing
    when piece[0] == "<"
      return :opening
    else return :text
    end
  end

  def build
    root_html_tag = nil
    current_tag = nil
    @pieces.each_with_index do |piece, index|
      next if piece.empty?
      piece_type = classify(piece)

      # If first tag is not <html>, create an HTML root tag
      if index == 0
        if piece[0..4].downcase == "<html"
          current_tag = Tag.new(piece)
        else
          current_tag = Tag.new("<html>")
        end
      end

      case piece_type
      when :closing
        current_tag = current_tag.parent #TODO
      when :opening
        new_tag = Tag.new(piece)
        current_tag.add_child(new_tag)
        current_tag = new_tag
      else
        current_tag.text = piece
      end
    end

    piece_1 = Tag.new(@pieces[0])
    root_html_tag = ""
    unless piece_1.attributes[:type].downcase == "html"
      root_html_tag = Tag.new("<html>")
    end
    root_html_tag
  end
end
