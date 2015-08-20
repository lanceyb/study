require 'benchmark/ips'

# 这是最老土的解法，效率太低了 O(n^2)
def two_sum1 nums, target
  i = 0
  while i < nums.length do
    j = i + 1
    while j < nums.length do
      return [i, j].sort if nums[i] + nums[j] == target
      j += 1
    end
    i += 1
  end
end

# 用hsh存储nums，eg: [3, 2, 4] => [[3, 1], [2, 2], [4, 3]] => { 3 => 1, 2 => 2, 4 => 3 }
# 遍历一遍nums，target - sum = new_target，判断hsh[new_target]是否存在；若存在，则有；否则下一个
def two_sum nums, target
  hash = nums.map.with_index.to_h
  found = nums.find.with_index do |num, index|
    target_index = hash[target - num] and target_index != index
  end
  raise "Not two sum solution!" if found.nil?
  [nums.index(found) + 1, hash[target - found] + 1].sort
end

#p two_sum(0.step(32044, 2).to_a, 16022)
#p two_sum([0, 2, 4, 6, 8, 10], 8)
#p two_sum([3, 2, 4], 6)
#p two_sum([1, 2, 0, 0, 4, 0], 0)

# 为什么用hash存储，效率会快很多？
# 这个算法复杂度好像也是O(n^2)
def two_sum2 nums, target
  for i in (0...nums.length) do
    target_index = nil
    found = nums.find.with_index do |num, j|
      target_index = j
      num == target - nums[i] && j != i
    end
    if !found.nil?
      return [i + 1, target_index + 1].sort
    end
  end
  raise "Not two sum solution!"
end

#p two_sum2(0.step(32044, 2).to_a, 16022)
#p two_sum2([0, 2, 4, 6, 8, 10], 8)
#p two_sum2([3, 2, 4], 6)
#p two_sum2([0, 2, 4, 0], 0)
#p two_sum2([1, 2, 0, 4, 0, 0], 0)


#Benchmark.ips do |x|
  #x.config time: 5, warmup: 2

  #x.report("two sum") { two_sum(0.step(32044, 2).to_a, 16022) }
  #x.report("two sum2") { two_sum(0.step(32044, 2).to_a, 16022) }
#end
