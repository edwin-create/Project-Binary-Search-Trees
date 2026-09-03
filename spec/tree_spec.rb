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
end
