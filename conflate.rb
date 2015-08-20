require "minitest/autorun"

def conflat ordi_array
  #ordi_array.flatten!.sort.first(5)
end

class ConflateTest < Minitest::Test

  def test_ordi_array
    a = [1, 7, 15, 27]
    b = [2, 9, 10, 22]
    c = [3, 6, 11, 29]

    assert_equal conflat([a, b, c]), [1, 2, 3, 6, 7]
  end

end
