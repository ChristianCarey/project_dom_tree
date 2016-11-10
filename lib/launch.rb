require_relative 'tag.rb'
require_relative 'tag_attributes.rb'
require_relative 'dom.rb'

d = Dom.new
d.load
d.split
puts d.pieces
