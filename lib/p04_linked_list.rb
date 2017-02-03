
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def include?(key)
    return false if get(key).nil?
    true
  end

  def append(key, val)
     link = Link.new(key,val)
     old_last = self.last
     old_last.next = link
     link.prev = old_last
     link.next = @tail
     @tail.prev = link
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
      end
    end
  end

  def remove(key)
    self.each do |link|
      if link.key == key
        link.remove
      end
    end

  end

  def each(&prc)
    current_link = self.first
    until current_link == @tail
      prc.call(current_link)
      current_link =  current_link.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
