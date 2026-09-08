require_relative './lib/node'
require_relative './lib/tree'

tree = Tree.new([1, 2, 3, 4, 5])

tree.level_order.each { |value| puts value }
tree.pretty_print
