require_relative 'tag.rb'
require_relative 'tag_attributes.rb'
require_relative 'dom_builder.rb'

d = DomBuilder.new
d.load
d.render
# d.pieces.each do |piece|
#   p piece 
#   puts
# end

# a = TagAttributes.new('<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">')
# p a.hash