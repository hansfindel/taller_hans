module SessionsHelper

def const_defined?(name)
  super || self.superclass.const_defined?(name)
end

end
