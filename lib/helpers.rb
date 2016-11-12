
def check_arguments(options= {})
  options.each do |parameter, klass|    

    raise ArgumentError.new("#{parameter} is not a #{klass}") unless parameter.is_a?(klass)
  end
end

class Object
  alias :is_an? :is_a?
end

def each_child(tag, first=true, &block)
  yield(tag) unless first
  if tag.is_a?(Tag)
    tag.children.each do |child|
      each_child(child, false, &block)
    end
  end
end