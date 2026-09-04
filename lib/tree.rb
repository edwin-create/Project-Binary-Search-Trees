class Tree
  attr_accessor :root

  # 2. initialize automatically calls build_tree for the user
  def initialize(array)
    sorted_array = array.sort.uniq
    @root = build_tree(sorted_array)
  end

  def include?(value)
    current = @root
    while current
      return true if current.data == value

      current = if value < current.data
                  current.left
                else
                  current.right

                end
    end
    false
  end

  def insert(value) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
    if @root.nil?
      @root = Node.new(value)
      return
    end
    new_node = Node.new(value)
    current = @root
    while current
      if value < current.data && current.left.nil?
        current.left = new_node
        return
      elsif value < current.data
        current = current.left
      elsif value > current.data && current.right.nil?
        current.right = new_node
        return
      else
        current = current.right
      end
    end
  end

  def delete(value) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
    return nil if @root.nil?

    parent = nil
    current = @root

    # phase1: Traverse through the tree to find the node to delete.
    while current && current.data != value
      parent = current
      current = if current.data > value
                  current.left
                else
                  current.right
                end
    end

    # case1: If the node to delete is a leaf node, simply remove it from the tree.
    # Stop if the value wasn't in the tree
    return nil if current.nil?

    if current.left.nil? && current.right.nil?
      if parent.nil?
        @root = nil
      elsif parent.left == current
        parent.left = nil
      else
        parent.right = nil
      end

    # case2: If the node to delete has one child, replace the node with its child.

    elsif current.left.nil? || current.right.nil?
      child = current.left || current.right

      if parent.nil?
        @root = child
      elsif parent.left == current
        parent.left = child
      else
        parent.right = child
      end
    # case3: If the node to delete has two children, find the successor (the smallest value in the right subtree), replace the node's value with the successor's value, and then delete the successor node. # rubocop:disable Layout/LineLength
    else
      successor_parent = current
      successor = current.right
      while successor.left
        successor_parent = successor
        successor = successor.left
      end
      current.data = successor.data
      child = successor.right
      if successor_parent.left == successor
        successor_parent.left = child
      else
        successor_parent.right = child
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  private # Good practice: hide build_tree from outside users

  # 3. build_tree runs recursively using the sorted_array passed from initialize
  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2

    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid + 1)..])
    root
  end
end
