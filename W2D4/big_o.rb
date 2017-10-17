# Find longest string in array in O(n^2); nested loops; bubble sort

def sluggish_octopus(arr)

  sorted = false
  until sorted
    sorted = true
    arr.each_index do |idx|
      next if idx + 1 > arr.length - 1
      if arr[idx].length > arr[idx + 1].length
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
        sorted = false
      end
    end
  end

  arr.last
end

p sluggish_octopus(["a", "abcd", "abcdef", "ab", "abc", "abcde"])

# Find longest string in array in O(n log n)); merge sort; quick sort
# How to return the last element from this recursive sort?
# def dominant_octopus(arr)
#   return arr if arr.length < 2
#
#   prc = Proc.new { |x, y| x <=> y }
#   pivot = arr.first
#
#   left = arr[1..-1].select { |el| prc.call(el, pivot) == -1 }
#   right = arr[1..-1].reject { |el| prc.call(el, pivot) == -1 }
#   dominant_octopus(left) + [pivot] + dominant_octopus(right)
#
# end

def dominant_octopus(arr)
  return arr if arr.length < 2
  mid = arr.length / 2

  sorted_left = dominant_octopus(arr.take(mid))
  sorted_right = dominant_octopus(arr.drop(mid))

  merge(sorted_left, sorted_right)
end

def merge(arr1, arr2)
  merged = []
  until arr1.empty? || arr2.empty?
    case arr1.first <=> arr2.first
    when -1
      merged << arr1.shift
    when 0
      merged << arr1.shift
    when 1
      merged << arr2.shift
    end
  end
  merged.concat(arr1)
  merged.concat(arr2)
  merged
end


p dominant_octopus(["a", "abcd", "abcdef", "ab", "abc", "abcde"])

# Find longest string in array in O(n)

def clever_octopus(arr)
  longest = arr.first

  arr.each do |el|
    longest = el if el.length > longest.length
  end
  longest
end

p clever_octopus(["a", "abcd", "abcdef", "ab", "abc", "abcde"])

# Find longest string in array in O(n)

def slow_dance(direction, tiles_array)

  tiles_array.each_with_index do |dir, idx|
    return idx if direction == dir
  end
  nil
end

p slow_dance("up", ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ])

# Find longest string in array in O(1); binary search...wait, does this
# still count as O(1)?

def constant_dance(direction, hash)
  hash.each do |key, value|
    return key if value == direction
  end
  nil
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

dir_hash = {}
i = 0
tiles_array.each do |dir|
  dir_hash[i] = dir
  i += 1
end

p constant_dance("right", dir_hash)
