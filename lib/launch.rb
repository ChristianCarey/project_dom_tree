require './tag.rb'
require './tag_attributes.rb'
require './dom.rb'

d = Dom.new
d.load
d.split
puts d.pieces