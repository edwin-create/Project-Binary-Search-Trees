require_relative '../lib/tree'

describe Tree do
  describe '#build_tree' do
    it 'creates a root node using the middle value' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.root.data).to eq(3)
    end
    it 'creates a root node using the middle value' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.root).to be_a(Node)
    end
    it 'creates a node for the left child' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.root).to be_a(Node)
    end

    it 'creates a node for the right child' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.root).to be_a(Node)
    end
  end
  describe '#include?' do
    it 'accepts a value and returns true if the given value is in the tree. False otherwise' do
      tree = Tree.new([1, 2, 3, 4, 5])
      expect(tree.include?(2)).to be(true)
    end
  end
  describe '#insert' do
    it 'accepts a value and inserts a new node with the given value in the correct location in the tree' do
      tree = Tree.new([1, 2, 3, 4, 5])
      tree.insert(6)
      expect(tree.include?(6)).to be(true)
    end
  end
  describe '#delete' do
    it 'accepts a value and deletes the node with the given value from the tree' do
      tree = Tree.new([1, 2, 3, 4, 5])
      tree.delete(3)
      expect(tree.include?(3)).to be(false)
    end
    it 'deletes a leaf node' do
      tree = Tree.new([8, 3, 10, 1, 6])

      tree.delete(6)

      expect(tree.root.left.right).to be_nil
    end
  end

  describe '#level_order' do
    it 'yields each value in level order' do
      tree = Tree.new([1, 2, 3, 4, 5])
      result = []

      tree.level_order do |value|
        result << value
      end

      expect(result).to eq([3, 2, 5, 1, 4])
    end

    it 'returns self when given a block' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.level_order { |value| value }).to eq(tree)
    end

    it 'returns an Enumerator when no block is given' do
      tree = Tree.new([1, 2, 3, 4, 5])

      expect(tree.level_order).to be_a(Enumerator)
    end
    it 'returns self when given a block, even if the tree is empty' do
      tree = Tree.new([])

      expect(tree.level_order { |value| value }).to eq(tree)
    end
  end
  describe '#inorder' do
    it 'returns self when given a block' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.inorder { |value| value }).to eq(tree)
    end

    it 'returns an Enumerator when no block is given' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.inorder).to be_a(Enumerator)
    end
    it 'returns self when given a block, even if the tree is empty' do
      tree = Tree.new([])

      expect(tree.inorder { |value| value }).to eq(tree)
    end
    it 'yields each value in inorder' do
      tree = Tree.new([1, 2, 3, 4, 5])
      result = []

      tree.inorder do |value|
        result << value
      end

      expect(result).to eq([1, 2, 3, 4, 5])
    end
    it 'yields values in inorder for a tree with two children' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
      result = []

      tree.inorder do |value|
        result << value
      end

      expect(result).to eq([1, 2, 3, 4, 5, 6, 7])
    end
  end
  describe '#preorder' do # rubocop:disable Metrics/BlockLength
    it 'returns self when given a block' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.preorder { |value| value }).to eq(tree)
    end

    it 'returns an Enumerator when no block is given' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.preorder).to be_a(Enumerator)
    end
    it 'returns self when given a block, even if the tree is empty' do
      tree = Tree.new([])

      expect(tree.preorder { |value| value }).to eq(tree)
    end
    it 'yields each value in preorder' do
      tree = Tree.new([1, 2, 3, 4, 5])
      result = []

      tree.preorder do |value|
        result << value
      end

      expect(result).to eq([3, 2, 1, 5, 4])
    end
    it 'yields values in preorder for a tree with two children' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
      result = []

      tree.preorder do |value|
        result << value
      end

      expect(result).to eq([4, 2, 1, 3, 6, 5, 7])
    end
  end
  describe '#postorder' do
    it 'returns self when given a block' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.postorder { |value| value }).to eq(tree)
    end

    it 'returns an Enumerator when no block is given' do
      tree = Tree.new([2, 1, 3, 5, 4])

      expect(tree.postorder).to be_a(Enumerator)
    end

    it 'returns self when given a block, even if the tree is empty' do
      tree = Tree.new([])

      expect(tree.postorder { |value| value }).to eq(tree)
    end

    it 'yields each value in postorder' do
      tree = Tree.new([1, 2, 3, 4, 5])
      result = []

      tree.postorder do |value|
        result << value
      end

      expect(result).to eq([1, 2, 4, 5, 3])
    end

    it 'yields values in postorder for a tree with two children' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
      result = []

      tree.postorder do |value|
        result << value
      end

      expect(result).to eq([1, 3, 2, 5, 7, 6, 4])
    end
  end
  describe '#height' do
    it 'returns the height of the node containing that value' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
      expect(tree.height(2)).to eq(1)
    end
  end
  describe '#depth' do
    it 'returns 0 for the root node' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.depth(4)).to eq(0)
    end

    it 'returns the number of edges from the root to the node' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.depth(2)).to eq(1)
      expect(tree.depth(1)).to eq(2)
      expect(tree.depth(7)).to eq(2)
    end

    it 'returns nil if the value is not found' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.depth(10)).to be_nil
    end

    it 'returns nil for an empty tree' do
      tree = Tree.new([])

      expect(tree.depth(4)).to be_nil
    end
  end
  describe '#find' do # rubocop:disable Metrics/BlockLength
    it 'returns the node containing the given value' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      node = tree.find(5)

      expect(node).to be_a(Node)
      expect(node.data).to eq(5)
    end

    it 'returns the root node when searching for the root value' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      node = tree.find(4)

      expect(node).to eq(tree.root)
    end

    it 'returns the correct node when the value is in the left subtree' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      node = tree.find(1)

      expect(node.data).to eq(1)
    end

    it 'returns the correct node when the value is in the right subtree' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      node = tree.find(7)

      expect(node.data).to eq(7)
    end

    it 'returns nil when the value does not exist' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.find(10)).to be_nil
    end

    it 'returns nil when searching an empty tree' do
      tree = Tree.new([])

      expect(tree.find(5)).to be_nil
    end
  end
  describe '#balanced?' do
    it 'returns true for a balanced tree' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.balanced?).to be true
    end

    it 'returns true for a tree with one node' do
      tree = Tree.new([1])

      expect(tree.balanced?).to be true
    end

    it 'returns true for an empty tree' do
      tree = Tree.new([])

      expect(tree.balanced?).to be true
    end

    it 'returns true when the subtree heights differ by one' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      tree.root.left.left.left = Node.new(0)

      expect(tree.balanced?).to be true
    end

    it 'returns false when a subtree heights differ by more than one' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      tree.root.left.left.left = Node.new(0)
      tree.root.left.left.left.left = Node.new(-1)

      expect(tree.balanced?).to be false
    end
  end
  describe '#rebalance' do
    it 'rebalances an unbalanced tree' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      tree.root.right.right.right = Node.new(8)
      tree.root.right.right.right.right = Node.new(9)

      expect(tree.balanced?).to be false

      tree.rebalance

      expect(tree.balanced?).to be true
    end

    it 'keeps all the original values' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      tree.root.right.right.right = Node.new(8)
      tree.root.right.right.right.right = Node.new(9)

      tree.rebalance

      values = []
      tree.inorder { |value| values << value }

      expect(values).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it 'does not lose values when rebalancing a tree containing duplicate input values' do
      tree = Tree.new([1, 2, 2, 3, 4, 5, 5, 6, 7])

      tree.root.right.right.right = Node.new(8)

      tree.rebalance

      values = []
      tree.inorder { |value| values << value }

      expect(values).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      expect(tree.balanced?).to be true
    end

    it 'handles an already balanced tree' do
      tree = Tree.new([1, 2, 3, 4, 5, 6, 7])

      expect(tree.balanced?).to be true

      tree.rebalance

      expect(tree.balanced?).to be true
      expect(tree.root.data).to eq(4)
    end

    it 'handles an empty tree' do
      tree = Tree.new([])

      tree.rebalance

      expect(tree.root).to be_nil
      expect(tree.balanced?).to be true
    end
  end
end
