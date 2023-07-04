require_relative './lib/node.rb'
require_relative './lib/tree.rb'

# driver script

# 1. Create a binary search tree from an array of random numbers
array = (Array.new(15) { rand(1..100)})
bst = Tree.new(array)

# 2. Confirm that the tree is balanced by calling #balanced?
p "Balanced? #=> #{bst.balanced?}"
bst.pretty_print

# 3. Print out all elements in level, pre, post, and in order
p "Level order: #{bst.level_order}"
p "Preorder:    #{bst.preorder}"
p "Postorder:   #{bst.postorder}"
p "Inorder:     #{bst.inorder}"

# 4. Unbalance the tree by adding several numbers > 100
15.times { bst.insert(rand(101..199)) }

# 5. Confirm that the tree is unbalanced by calling #balanced?
p "Balanced? #=> #{bst.balanced?}"
bst.pretty_print

# 6. Balance the tree by calling #rebalance
bst.rebalance

# 7. Confirm that the tree is balanced by calling #balanced?
p "Balanced? #=> #{bst.balanced?}"
bst.pretty_print

# 8. Print out all elements in level, pre, post and in order.
p "Level:  #{bst.level_order}"
p "Pre:    #{bst.preorder}"
p "Post:   #{bst.postorder}"
p "In:     #{bst.inorder}"

