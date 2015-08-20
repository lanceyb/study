def reverse(x)
  max = 2**31
  min = -2**31 + 1
  rs = (x > 0 ? 1 : -1) * x.to_s.reverse.to_i
  return 0 unless (min...max).include?(rs)
  rs
end
