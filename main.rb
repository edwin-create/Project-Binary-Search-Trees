require_relative './lib/node'
require_relative './lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })

tree.pretty_print

puts 'Initially balanced:'
puts tree.balanced?

puts 'Level order:'
tree.level_order { |value| puts value }

puts 'Preorder:'
tree.preorder { |value| puts value }

puts 'Postorder:'
tree.postorder { |value| puts value }

puts 'Inorder:'
tree.inorder { |value| puts value }

5.times do
  tree.insert(rand(101..200))
end

puts 'After adding numbers:'
puts tree.balanced?

tree.rebalance

puts 'After rebalancing:'
puts tree.balanced?

tree.pretty_print

puts 'Level order:'
tree.level_order { |value| puts value }

puts 'Preorder:'
tree.preorder { |value| puts value }

puts 'Postorder:'
tree.postorder { |value| puts value }

puts 'Inorder:'
tree.inorder { |value| puts value }
