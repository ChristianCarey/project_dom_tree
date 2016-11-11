require_relative 'helpers.rb'
require_relative 'tag.rb'
require_relative 'tag_attributes.rb'
require_relative 'dom_builder.rb'
require_relative 'dom_renderer.rb'
require_relative 'dom_searcher.rb'

d = DomBuilder.new
d.load
r = DomRenderer.new
r.render(d.root)
puts

# d.pieces.each do |piece|
#   p piece 
#   puts
# end
