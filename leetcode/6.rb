require "minitest/autorun"
# ZigZag Conversion
def convert s, num_rows
  case num_rows
  when 1 then
    return s
  when 2 then
    return s.each_char.group_by.with_index do |_, index|
      index % 2
    end.values.map(&:join).join
  else
    period = 2 * num_rows  - 2
  end
  rs = Array.new(num_rows) { Array.new }
  s.each_char.with_index do |char, index|
    pi = index / period
    first = 2*pi*(num_rows - 1)
    last = (2*pi + 1) * (num_rows - 1)
    if index == first
      rs[0][pi] = char
    elsif index ==  last
      rs[num_rows - 1][pi] = char
    elsif first < index and index < last
      rs[(index - 2*pi*(num_rows - 1)) % num_rows][2*pi] = char
    else
      rs[num_rows - 1 - (index - last)][2*pi + 1] = char
    end
  end
  rs.map(&:join).join
end

class ZigZagConversionTest < Minitest::Test
  def test_convert
    assert_equal "A", [["A"], [], []].map(&:join).join
    assert_equal "AB", convert("AB", 1)
    assert_equal "A", convert("A", 3)
  end
end
