def quicksort(array, &prc)
  return array if array.length < 2
  prc ||= Proc.new {|a, b| a <=> b}
  # < returns -1
  # > returns 1
  # == returns 0

  # pivot selection will vary efficiency
  pivot = array.last
  less_array = []
  more_array = []
  num_idx = 0
  #exclude last number
  while num_idx < (array.length - 1)
    num = array[num_idx]
    if prc.call(pivot, num) >= 0
      # default if num is less than or equal pivot 0 or 1 is returned
      less_array << num
    else
      # default if num is more then pivot -1 returned
      more_array << num
    end
    num_idx += 1
  end
  #recursive call to sort other halves
  less_array = quicksort(less_array, &prc)
  more_array = quicksort(more_array, &prc)
  # depending on the size of the less and more array Big-O can range from O(log(n)) to O(n^2) can be optimized by selecting different pivots
  #this particular implemntation uses a worst case memory complexity of O(n) but realisitically O(log(n)) b/c each recursive call is not of equal size
  return less_array + [pivot] + more_array
end
