def heapsort(array, &prc)
  prc ||= Proc.new{|a,b| a <=> b}
  #build a reverse heap
  heapify!(array, &prc)
  # this is the actual sort
  unheapify!(array, &prc)
  array
end


def heapify!(array, &prc)
  # we want to do the opposite of prc
  array.each_with_index do |el, idx|
    heapify_up!(array, idx, &prc) unless idx == 0
  end
end

# O(log(n))
def heapify_up!(array, idx, &prc)
  parent_idx = parent_idx(idx)
  return true if parent_idx == nil
  if prc.call(array[idx], array[parent_idx]) == 1
    array[idx], array[parent_idx] = array[parent_idx], array[idx]
    idx = parent_idx
    heapify_up!(array, idx, &prc)
  end
  array
end

def unheapify!(array, &prc)
  array_length = array.length
  while array_length > 0
    array_length -=1
    array[0], array[array_length] = array[array_length], array[0]
    heapify_down!(array, 0, array_length, &prc)
  end
end

# O(log(n))
def heapify_down!(array, idx, array_length, &prc)
  array_length ||= array.length
  children_idxs = child_idxs(idx, array_length)
  if children_idxs.length == 0
    return array
  elsif children_idxs.length == 1
    child_idx = children_idxs[0]
  else
    if prc.call(array[children_idxs[0]], array[children_idxs[1]]) == 1
      child_idx = children_idxs[0]
    else
      child_idx = children_idxs[1]
    end
  end
  if prc.call(array[idx], array[child_idx]) == -1
    array[idx], array[child_idx] = array[child_idx], array[idx]
    idx = child_idx
    heapify_down!(array, idx, array_length, &prc)
  end
  array
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
