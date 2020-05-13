require_relative '../bin/enumerables.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    let(:arr) { [2, 4, 1, 3] }
    let(:bedmas) { [] }
    it 'should return each element of an array' do
      expect(arr).to eq([2, 4, 1, 3])
    end

    it 'should return each element of an array multiplied by 2' do
      arr.my_each { |i| bedmas << i * 2 }
      expect(bedmas).to eq([4, 8, 2, 6])
    end

    it 'should return each element of an array addition by 1' do
      arr.my_each { |i| bedmas << i + 1 }
      expect(bedmas).to eq([3, 5, 2, 4])
    end

    it 'should return each element of an array division by 2' do
      arr.my_each { |i| bedmas << i.to_f / 2 }
      expect(bedmas).to eq([1.0, 2.0, 0.5, 1.5])
    end

    it 'should return enumerator if block is not given' do
      expect(arr.my_each.class).to eq(Enumerator)
    end

    it 'should return range of numbers in an array' do
      expect((1..5).my_each { |i| bedmas << i }).to eq([1, 2, 3, 4, 5])
    end
  end

  describe '#my_each_with_index' do
    let(:arr) { [2, 4, 1, 3] }
    let(:element) { [] }
    let(:idx) { [] }
    it 'should return each element and index of an array' do
      arr.my_each_with_index { |e, _i| element << e }
      arr.my_each_with_index { |_e, i| idx << i }
      expect(element).to eq([2, 4, 1, 3])
      expect(idx).to eq([0, 1, 2, 3])
    end
  end

  describe '#my_select' do
    let(:arr) { [2, 4, 1, 3] }
    it 'should return each element in a new array if block is true' do
      expect(arr.my_select(&:even?)).to eq([2, 4])
    end
  end

  describe '#my_all?' do
    let(:even) { [2, 4, 6, 8] }
    let(:not_even) { [2, 5, 6, 8] }
    it 'should return true if all elements are even' do
      expect(even.my_all?(&:even?)).to eq(true)
    end

    it 'should return false if one element is not even' do
      expect(not_even.my_all?(&:even?)).to eq(false)
    end

    it 'should return true only when none of the elements are false or nil when no block or argument is given' do
      expect([true, true, []].my_all?).to eq(true)
    end

    it 'should return false if one of the elements are false or nil when no block or argument is given' do
      expect([true, nil, []].my_all?).to eq(false)
    end

    it 'should return true if all of the elements are members of such class' do
      expect([1, 2, 3, 4].my_all?(Integer)).to eq(true)
    end

    it 'should return false if one of the elements is not a member of such class' do
      expect([1, 'a', 3.0, 4].my_all?(Integer)).to eq(false)
    end

    it 'should return true if all of the collection matches the Regex' do
      expect(%w[dog door].my_all?(/d/)).to eq(true)
    end

    it 'should return false if one of the collection doesnt match the Regex' do
      expect(%w[dog door open].my_all?(/d/)).to eq(false)
    end

    it 'should return true if all of the collection matches the pattern' do
      expect([3, 4, 7, 11].my_all?(3)).not_to eq(true)
    end
  end

  describe '#my_any?' do
    let(:even) { [1, 4, 5, 7] }
    let(:not_even) { [3, 5, 7, 1] }

    it 'should return true if any element is even' do
      expect(even.my_any?(&:even?)).to eq(true)
    end

    it 'should return false if any element is not even' do
      expect(not_even.my_any?(&:even?)).to eq(false)
    end

    it 'should return true if one of the elements is not false or nil when no block or argument is given' do
      expect([true, false, nil, []].my_any?).to eq(true)
    end

    it 'should return true if at least one of the elements is member of such class' do
      expect([1, 'a', 3.0, []].my_any?(Integer)).to eq(true)
    end

    it 'should return true if any of the collection matches the Regex' do
      expect(%w[dog woof woof].my_any?(/d/)).to eq(true)
    end

    it 'should return false if none of the collection doesnt match the Regex' do
      expect(%w[dog woof open].my_any?(/c/)).to eq(false)
    end

    it 'should return true if any of the collection matches the pattern' do
      expect([3, 4, 7, 11].my_any?(3)).to eq(true)
    end
  end

  describe '#my_none?' do
    let(:even) { [1, 4, 5, 7] }
    let(:not_even) { [3, 5, 7, 1] }

    it 'should return true if none olf the elements are even' do
      expect(not_even.my_none?(&:even?)).to eq(true)
    end

    it 'should return false if one element is even' do
      expect(even.my_none?(&:even?)).to eq(false)
    end

    it 'should return false when at least one element of the collection is not false or nil if no block is given' do
      expect([true, false, nil, []].my_none?).to eq(false)
    end

    it 'should return true if none of the elements is member of such class' do
      expect([1.0, 'a', 3.0, []].my_none?(Integer)).to eq(true)
    end

    it 'should return true if none of the collection doesnt match the Regex' do
      expect(%w[dog woof open].my_none?(/c/)).to eq(true)
    end

    it 'should return true if none of the collection matches the pattern' do
      expect([4, 4, 7, 11].my_none?(3)).to eq(true)
    end
  end

  describe '#my_count' do
    let(:arr) { [2, 4, 1, 3] }
    it 'should return how much elements are in an array' do
      expect(arr.my_count).to eq(4)
    end

    it 'should return the number of elements yielding a true value if a block is given' do
      expect(arr.my_count { |i| i > 2 }).to eq(2)
    end
  end

  describe '#my_map' do
    let(:arr) { [2, 4, 1, 3] }
    it 'should return enumerator if block is not given' do
      expect(arr.my_map.class).to eq(Enumerator)
    end

    it 'should return a new array after executing the given block' do
      expect(arr.my_map { |i| i + 2 }).to eq([4, 6, 3, 5])
    end

    it 'should return a new array after executing the proc on each element' do
      proc_array = proc { |i| i * 2 }
      expect(arr.my_map(proc_array)).to eq([4, 8, 2, 6])
    end

    it 'should return a new array after executing the block and proc' do
      proc_array = proc { |i| i * 2 }
      expect(arr.my_map { |i| i + 2 }.my_map(proc_array)).to eq([8, 12, 6, 10])
    end
  end

  describe '#my_inject' do
    let(:arr) { [2, 4, 1, 3] }

    it 'should combines all elements of enum by applying a binary operation, specified by a block' do
      expect(arr.my_inject(2) { |acc, curr| acc * curr }).to eq(48)
    end

    it 'should combine the elements of the enum using that symbol as a named method' do
      expect(arr.my_inject(:+)).to eq(10)
    end
  end
end
