def find_median_sorted_arrays(nums1, nums2)

  nums3 = (nums1 + nums2).sort

  if nums3.length % 2 == 0

    (nums3[nums3.length/2 - 1].to_i + nums3[nums3.length/2].to_i).to_f/2

  else

    nums3[nums3.length/2].to_i

  end

end
