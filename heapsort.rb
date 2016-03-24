def heapsort(array, &prc)
  prc ||= Proc.new{|a,b| a <=> b}
  #build a reverse heap
  heapify!(array, &prc)
  # this is the actual sort
  unheapify!
end


def heapify!(array, &prc)
  # we want to do the opposite of prc
  array.each_with_index do |el, idx|
    heapify_up!(array, idx, &prc) unless idx == 0
  end
end

def heapify_up!(array, idx, &prc)
  parent_idx = parent_idx(idx)
  return true if parent_idx == nil
  if prc.call(array[idx], array[parent_idx]) == 1
    array[idx], array[parent_idx] = array[parent_idx], array[idx]
    idx = parent_idx
    heapify_up!(array, idx, &prc)
  end
  idx
end

def parent_idx(idx)
  parent = (idx - 1) / 2
  if parent >= 0
    parent
  else
    nil
  end
  # 0 1 2 3 4 5 6 7 8 9
  # a b c d e f g h i j
  # b's parent is 0
  # c's parrent is a
  # d's parent is b
  # e's parent is b
  # f's parent is c
  # g's parent is c
  # h's parent is d
  # i's parent is d
  # j's parent is e
end

def child_idxs(idx, array_length)
  [idx * 2 + 1, idx * 2 + 2].select {|el| el < array_length}
  # 0 1 2 3 4 5 6 7 8 9
  # a b c d e f g h i j
  # a's children is 1 2
  # b's children is 3 4
  # c's children is 5 6
  # d's children is 7 8
  # e's children is 9

end
