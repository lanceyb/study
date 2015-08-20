require "minitest/autorun"

# eg: abccba => #a#b#c#c#b#a
def append_symbol str, symbol
  str.each_char.to_a
    .tap { |arr| arr.unshift(nil); arr.push(nil); }
    .join(symbol)
end

class AppendSymbolTest < Minitest::Test
  def test_append_symbol
    assert_equal "#a#b#c#", append_symbol("abc", "#")
    assert_equal "*a*b*c*", append_symbol("abc", "*")
  end
end

def max_aplindrome_radius str, index
  i = 0
  while i < index && index + i < str.length
    if str[index - i - 1] == str[index + i + 1]
      i += 1
    else
      break
    end
  end
  i
end

class MaxAplindromeRadiusTest < Minitest::Test
  def test_max_aplindrome_radius_test
    assert_equal 6, max_aplindrome_radius("#a#b#c#c#b#a#", 6)
    assert_equal 1, max_aplindrome_radius("abcdc", 3)
    assert_equal 0, max_aplindrome_radius("#a#", 0)
  end
end

def bad_longest_palindrom str
  new_str = append_symbol(str, "#")

  max_radii = []
  i = 0
  while i < new_str.length
    max_radii << max_aplindrome_radius(new_str, i)
    i += 1
  end
  max_radii.sort.last
end

class BadLongestPalindromTest < Minitest::Test
  def test_true
    assert_equal 6, bad_longest_palindrom("abccba")
    assert_equal 7, bad_longest_palindrom("abcdcba")
    assert_equal 0, bad_longest_palindrom("")
    assert_equal 1, bad_longest_palindrom("abc")
  end
end

###############################
#                             #
# 回文算法 Manacher Algorithm #
#                             #
###############################

def feel_in_radius before_radii
  max_radius = before_radii.last
  index = before_radii.length - 1
  i = 1
  while i < max_radius
    # before_radii[index - i] is the radius of i
    # the max right border of index
    if before_radii[index - i] < (max_radius + index) - (i + index)
      before_radii[index + i] = before_radii[index - i]
      i += 1
    else
      break
    end
  end
  [index + i, before_radii]
end

class FeelInRadiusTest < Minitest::Test
  def test_true
    assert_equal [15, [0, 1, 0, 3, 0, 1, 0, 7, 0, 1, 0, 9, 0, 1, 0]], feel_in_radius([0, 1, 0 , 3, 0, 1, 0, 7, 0, 1, 0, 9])
    assert_equal [1, [0]], feel_in_radius([0])
    assert_equal [2, [0, 1]], feel_in_radius([0, 1])
    assert_equal [7, [0, 1, 0, 4, 0, 1, 0]], feel_in_radius([0, 1, 0, 4])
    assert_equal [3, [0, 1, 2]], feel_in_radius([0, 1, 2])
  end
end

def longest_palindrome str
  new_str = append_symbol(str, "#")

  max_radii = []
  i = 0
  while i < new_str.length
    j = 0
    while j < i && j + i < new_str.length
      if new_str[i - j - 1] == new_str[j + i + 1]
        j += 1
      else
        break
      end
    end
    max_radii.push j
    index = i
    k = 1
    while k < j
      if max_radii[i - k] < (j + i) - (k + i)
        max_radii[i + k] = max_radii[i - k]
        k += 1
      else
        break
      end
    end
    i += k
  end
  max_l = max_radii.sort.last
  index = max_radii.index(max_l)
  new_str[(index - max_l)..(index + max_l)].gsub(/#/, "")
end

class LongestPalindromTest < Minitest::Test
  def test_true
    #assert_equal 6, longest_palindrome("abccba")
    #assert_equal 7, longest_palindrome("abcdcba")
    #assert_equal 0, longest_palindrome("")
    #assert_equal 1, longest_palindrome("abc")
    #assert_equal "", longest_palindrome("")
    #assert_equal "a", longest_palindrome("abc")
    #assert_equal "ccc", longest_palindrome("ccc")
    #assert_equal "e" * 10000, longest_palindrome("e" * 10000)
    assert_equal "0"*1000, longest_palindrome("0"*1000)
  end
end
