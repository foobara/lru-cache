module Foobara
  class LruCache
    # doubly-linked list whose methods live in LruCache for now
    class Node
      attr_accessor :prev, :next
      attr_reader :key, :value

      def initialize(key, value)
        @value = value
        @key = key
      end
    end

    attr_reader :size

    def initialize(capacity = 10)
      @capacity = capacity
      @size = 0
      @key_to_node = {}
      @head = @tail = nil
    end

    def cached(key)
      if @key_to_node.key?(key)
        node = @key_to_node[key]
        move_node_to_front(node)
        node.value
      else
        value = yield
        node = Node.new(key, value)
        @key_to_node[key] = node
        prepend_node(node)
        value
      end
    end

    def key?(key)
      @key_to_node.key?(key)
    end

    private

    def move_node_to_front(node)
      return if node == @head

      prev_node = node.prev
      next_node = node.next

      if node == @tail
        @tail = prev_node
        @tail.next = nil
      else
        prev_node.next = next_node
        next_node.prev = prev_node
      end

      @head.prev = node
      node.next = @head
      node.prev = nil
      @head = node
    end

    def prepend_node(node)
      if @size == 0
        @head = @tail = node
        @size = 1
      else
        @head.prev = node
        node.next = @head
        @head = node

        if @size < @capacity
          @size += 1
        else
          @key_to_node.delete(@tail.key)
          prev_node = @tail.prev
          if prev_node
            prev_node.next = nil
            @tail = prev_node
          end
        end
      end
    end
  end
end
