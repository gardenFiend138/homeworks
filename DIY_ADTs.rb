class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack.push(el)
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end

end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.push(el)
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end
end

class Map
  def initialize
    @map = []
  end

  def assign(key, value)

    @map.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    @map << [key, value]

  end

  def lookup(key)
    @map.each do |pair|
      return pair.last if pair.first == key
    end
    nil
  end

  def remove(key)
    @map.each_with_index do |pair, idx|
      if pair.first == key
        @map.delete_at(idx)
        return
      end
    end
  end

  def show
    @map
  end

end
