module Foobara
  class LruCache
    # doubly-linked list whose methods live in LruCache for now
    class Node
      attr_accessor :prev, :next
      attr_reader :value

      def initialize(value)
        @value = value
      end
    end

    attr_reader :size

    def initialize(capacity = 100)
      @capacity = capacity
      @size = 0
      @key_to_node = {}
      @head = @tail = nil
    end

    def cached(key)
      if @key_to_node.key?(key)
        move_node_to_front(key)
      else
        value = yield
        prepend_node(value)
      end
    end

    private

    def move_node_to_front(key)
      node = @key_to_node[key]
      node.value

      unless node == @head
        delete_node(node)

        node.next = @head&.next
        @head = node
      end

      node.value
    end

    def delete_node(node)
      if node == @tail
        if node.prev
          @tail = node.prev
        end
      end

      prev_node = node.prev

      if prev_node
        node.prev = nil
        prev_node.next = node.next
      end

      if node.next
        node.next.prev = prev_node
      end
    end

    def prepend_node(value)
      node = Node.new(value)
      @key_to_node[node.value] = node

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
          @key_to_node.delete(@tail.value)
          @tail.prev.next = nil
          @tail = @tail.prev
        end
      end

      value
    end
  end
end
