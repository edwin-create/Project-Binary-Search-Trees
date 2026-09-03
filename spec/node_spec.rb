require_relative '../lib/node'

describe Node do
  describe '#initialize' do
    it 'stores the data' do
      node = Node.new(5)
      expect(node.data).to eq(5)
    end
    it 'starts with no left child' do
      node = Node.new(5)
      expect(node.left).to be_nil
    end
    it 'starts with no right child' do
      node = Node.new(5)
      expect(node.right).to be_nil
    end
  end
end
