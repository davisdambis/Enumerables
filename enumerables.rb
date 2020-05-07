# Enumerable methods

module Enumerable
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  # my_each

  def my_each
    return to_enum unless block_given?
    return to_a if self.class == Range

    length.times { |i| yield(self[i]) }
    self
  end

  # end of my_each

  # my_each_with_index

  def my_each_with_index
    return to_enum unless block_given?

    length.times { |i| yield(self[i], i) }
    self
  end

  # end of my_each_with_index

  # my_select

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each { |i| arr.push(i) if yield(i) }
    arr
  end

  # end of my_select

  # my_all?

  def my_all?(arg = nil)
    if_all = true
    my_each do |i|
      if block_given? || arg.nil?
        return false if i.nil? || i == false
      elsif arg.class == Class
        return false unless i.is_a?(arg)
      elsif arg.class == Regexp
        return false unless i =~ arg
      else
        if_all = false unless i == arg
      end
    end
    if_all
  end

  # end of my_all?

  # my_any?

  def my_any?(arg = nil, &block)
    if_any = false
    my_each do |i|
      if block_given?
        return true if block.call(i)
      elsif arg.nil?
        return true if i
      elsif arg.class == Class
        return true if i.is_a?(arg)
      elsif arg.class == Regexp
        return true if i =~ arg
      elsif i == arg
        if_any = true
      end
    end
    if_any
  end

  # end of my_any?

  # my_none?

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  # end of my_none?

  # my_count

  def my_count(num = nil)
    count = 0
    my_each do |i|
      if block_given?
        count += 1 if yield(i) == true
      elsif num.nil?
        count += 1
      elsif i == num
        count += 1
      end
    end
    count
  end

  # end of my_count

  # my_map

  def my_map(proc = nil)
    arr = []
    my_each do |i|
      if proc.nil?
        return to_enum unless block_given?

        arr.push(yield(i))
      else
        arr.push(proc.call(i))
      end
    end
    arr
  end

  # end of my_map

  # my_inject

  def my_inject(init = nil, ele = nil)
    ele = init if ele.nil?
    if init.nil? || init.is_a?(Symbol)
      arr = drop(1)
      init = to_a[0]
    else
      arr = to_a
    end
    arr.my_each do |i|
      init = block_given? ? yield(init, i) : init.send(ele, i)
    end
    init
  end

  # end of my_inject
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

# multiply_els

def multiply_els
  my_inject(1) { |n1, n2| n1 * n2 }
end

# end of multiply_els
