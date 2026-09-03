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

  def insert(value) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
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
