require_relative 'tag.rb'
require_relative 'tag_attributes.rb'
require_relative 'dom.rb'

d = Dom.new
d.load
d.build
d.render
# d.pieces.each do |piece|
#   p piece 
#   puts
# end

