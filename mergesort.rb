def mergesort(array, &prc)
  prc ||= Proc.new{|a,b| a <=> b}
  return array if array.length < 2
  pivot_idx = array.length/2
  array_left = array.slice(0,pivot_idx)
  array_right = array.drop(pivot_idx)
  # recursive call makes this a log(n) time complexity
  # however the merge requires n time there for O(log(n))
  merge(
    mergesort(array_left, &prc),
    mergesort(array_right, &prc),
    &prc
  )

end


def merge(left, right, &prc)
  result = []
  while left.length > 0 && right.length > 0
    if prc.call(left.first, right.first) >= 0
      #default case if left.first > right.first 1
      result << right.shift
    elsif prc.call(left.first, right.first) < 0
      result << left.shift
    end
  end
  # at the end of the loop left or right will still have elements .: we must concat
  result + left + right
end
