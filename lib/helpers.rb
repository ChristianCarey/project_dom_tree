def check_arguments(options)
  options.each do |parameter, klass|    
    raise ArgumentError.new("#{parameter} must be a #{klass}") unless parameter.is_a?(klass)
  end
end

class Object
  alias :is_an? :is_a?
end
