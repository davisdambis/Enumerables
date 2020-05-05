# Enumerable methods

module Enumerable
  # my_each

  def my_each
    length.times { |i| yield(self[i]) }
    self
  end

  # end of my_each

  # my_each_with_index
  def my_each_with_index
    length.times { |i| yield(self[i], i) }
    self
  end

  # end of my_each_with_index

  # my_select

  def my_select
    arr = []
    my_each { |i| arr.push(i) if yield(i) }
    arr
  end

  # end of my_select

  # my_all?

  def my_all?
    if_all = true
    my_each do |i|
      break if_all = false unless yield(i)
    end
    if_all
  end

  # end of my_all?

  # my_any?

  def my_any?
    if_any = false
    my_each do |i|
      break if_any = true if yield(i)
    end
    if_any
  end

  # end of my_any?

  # my_none?

  def my_none? 
    if_none = true
    my_each do |i|
      break if_none = false if yield(i)
    end
    if_none
  end

  # end of my_none?

  # my_count

  def my_count(num)
    count = 0
    my_each { |i| count += 1 if num == i }
    count
  end

  # end of my_count

  # my_map

  def my_map(num = nil)
    arr = []
    if block_given?
      my_each { |i| arr.push(yield(i)) }
    else
      my_each { |i| arr.push(num.call(i)) }
    end
    arr
  end

  # end of my_map

  # my_inject

  def my_inject(acc = 0)
    my_each { |i| acc = yield(acc, i) }
    acc
  end

  # end of my_inject

  # multiply_els

  def multiply_els(arr)
    arr.my_inject(1) { |n1, n2| n1 * n2 }
  end

  # end of multiply_els
end
