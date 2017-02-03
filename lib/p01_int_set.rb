class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise "Out of bounds" if num > @store.length - 1 || num < 0
    @store[num] = true
    num
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    raise "Out of bounds" unless num.between?(0, 50)
    self[num] << num unless self[num].include?(num)
    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return false unless self[num].include?(num)
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      @count += 1
      if @count > num_buckets
        resize!
        @count += 1
      end
      self[num] << num
    end
    num
  end

  def remove(num)
    if self[num].include?(num)
      @count -= 1
      self[num].delete(num)
    end
    num
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    previous_num_buckets = @count - 1
    previous_buckets = @store.flatten
    @store = Array.new(previous_num_buckets * 2) {Array.new}
    @count = 0
    previous_buckets.each do |el|
      insert(el)
    end
  end
end
