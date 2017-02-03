require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
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

  def include?(key)
    num = key.hash
    self[num].include?(num)
  end

  def remove(key)
    num = key.hash
    if self[num].include?(num)
      @count -= 1
      self[num].delete(num)
    end
    num
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
