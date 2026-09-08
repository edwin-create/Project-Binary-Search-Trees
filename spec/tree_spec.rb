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
end
