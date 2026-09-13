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

  # def level_order
  #   return enum_for(:level_order) unless block_given?
  #   return self if @root.nil?
  #
  #   queue = [@root]
  #
  #   until queue.empty?
  #     current = queue.shift
  #     yield current.data if block_given?
  #     queue << current.left if current.left
  #     queue << current.right if current.right
  #   end
  #
  #   self
  # end

  def level_order(&block)
    return enum_for(:level_order) unless block_given?
    return self if @root.nil?

    queue = [@root]

    level_order_helper(queue, &block)
    self
  end

  def inorder(&block)
    return enum_for(:inorder) unless block_given?
    return self if @root.nil?

    inorder_helper(@root, &block)
    self
  end

  def preorder(&block)
    return enum_for(:preorder) unless block_given?
    return self if @root.nil?

    preorder_helper(@root, &block)
    self
  end

  def postorder(&block)
    return enum_for(:postorder) unless block_given?
    return self if @root.nil?

    postorder_helper(@root, &block)
    self
  end

  def height(value) # rubocop:disable Metrics/MethodLength
    current = @root

    return if current.nil?

    while current && current.data != value
      current = if value < current.data

                  current.left
                else
                  current.right
                end
    end
    return nil if current.nil?

    height_helper(current)
  end

  def depth(value) # rubocop:disable Metrics/MethodLength
    current = @root
    count = 0

    while current && current.data != value
      if value < current.data
        current = current.left
        count += 1 # rubocop:disable Style/IdenticalConditionalBranches
      else
        current = current.right
        count += 1 # rubocop:disable Style/IdenticalConditionalBranches
      end
    end

    return nil if current.nil?

    count if current.data == value
  end

  def find(value) # rubocop:disable Metrics/MethodLength
    current = @root
    return nil if current.nil?
    return current if current.data == value

    while current && current.data != value
      current = if current.data > value
                  current.left
                else
                  current.right
                end
    end
    return nil if current.nil?

    current
  end

  def balanced?
    return true if @root.nil?

    return true if @root.left.nil? && @root.right.nil?

    balanced_helper(@root)
  end

  def rebalance # rubocop:disable Metrics/MethodLength
    return if @root.nil?

    queue = [@root]
    values = []

    until queue.empty?
      current = queue.shift
      values << current.data
      queue << current.left if current.left
      queue << current.right if current.right
    end
    sorted_queue = values.sort.uniq
    @root = build_tree(sorted_queue)
  end

  private

  def balanced_helper(node)
    return true if node.nil?

    left_height = height_helper(node.left)
    right_height = height_helper(node.right)

    flag = (left_height - right_height).abs

    return false if flag > 1

    balanced_helper(node.left) && balanced_helper(node.right)
  end

  #  Good practice: hide height_helper from outside users
  def height_helper(node)
    return -1 if node.nil?

    1 + [height_helper(node.left), height_helper(node.right)].max
  end

  #  Good practice: hide postorder_helper from outside users
  def postorder_helper(node, &block)
    return if node.nil?

    postorder_helper(node.left, &block)
    postorder_helper(node.right, &block)
    yield node.data
  end

  # Good practice: hide preorder_helper from outside users
  def preorder_helper(node, &block)
    return if node.nil?

    yield node.data
    preorder_helper(node.left, &block)
    preorder_helper(node.right, &block)
  end

  # Good practice: hide level_order_helper from outside users

  def level_order_helper(queue, &block)
    return if queue.empty?

    current = queue.shift
    yield current.data if block_given?
    queue << current.left if current.left
    queue << current.right if current.right

    level_order_helper(queue, &block)
  end

  # Good practice: hide inorder_helper from outside users

  def inorder_helper(node, &block)
    return if node.nil?

    inorder_helper(node.left, &block)
    yield node.data
    inorder_helper(node.right, &block)
  end

  # Good practice: hide build_tree from outside users

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
