class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    integer = 0
    self.each_with_index do |el, idx|
      integer += (el.ord * idx)
    end
    integer.hash
  end
end

class String
  def hash
    integer = 0
    self.each_char.with_index do |el, idx|
      integer += (el.ord * idx)
    end
    integer.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    integer = 0
    self.each do |key, value|
      integer += (key.to_s.ord * value.ord)
    end
    integer.hash
  end
end
