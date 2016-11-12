require_relative 'helpers.rb'
require_relative 'tag.rb'
require_relative 'tag_attributes.rb'
require_relative 'dom_builder.rb'
require_relative 'dom_renderer.rb'
require_relative 'dom_searcher.rb'

d = DomBuilder.new
d.load
r = DomRenderer.new
s = DomSearcher.new
r.render(d.root)

# headings = s.find_by_attribute(d.root, :class, "story-heading")

# headings.each do |tag|
#   puts "#{tag.attributes}"
# end

# headings.each do |tag|
#   tag.type = "div"
# end

# headings.each do |tag|
#   puts "#{tag.attributes}"
# end


# s.tag_stats(d.root).each do |k,v|
#   puts "#{k}: #{v}"
#   puts
# end
# puts

# d.pieces.each do |piece|
#   p piece 
#   puts
# end
