class Tree
  def initialize(array)
    @arr = array
    @root = nil
    self.build_tree
  end 

  def build_tree(arr = @arr)
    @arr = nil                      # => no longer necessary to store
    return nil if arr.empty?         # => base condition

    arr = arr.uniq.sort
    middle = arr.size/2
    root = Node.new(arr[middle])
    root.left = build_tree(arr.slice(0...middle))
    root.right = build_tree(arr.slice(middle+1..-1))

    @root = root
    root
  end 

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, node = @root)
    return Node.new(data) if node.nil?         # => base condition

    node.left = insert(data, node.left) if data < node.data
    node.right = insert(data, node.right) if data > node.data
    node
  end

  def delete(value, node = @root)
    return node if node.nil?         # => base condition
    
    if value < node.data 
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else 
      # if node to be deleted only has one child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # if both child exists, find the min value at right child
      next_min = node.right              
      next_min = next_min.left until next_min.left.nil?  

      # bring the min value to replace the deleted node
      node.data = next_min.data
      # delete the old reference of min value w/ recurrency to avoid duplicates
      node.right = delete(next_min.data, node.right)
    end 
    node
  end

  def find(value, node = @root)
    return nil if node.nil?         # => base condition

    if node.data > value
      find(value, node.left)
    elsif node.data < value
      find(value, node.right)
    else 
      node
    end
  end 

  def level_order(queue = [@root], level_arr = [], &block)
    return if queue.empty?         # => base condition

    node = queue.shift
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    level_arr << node
    level_order(queue, level_arr, &block)
    
    return level_arr.map {|elem| block.call(elem.data)} if block_given?
    return level_arr.map { |elem| elem.data } unless block_given?
  end 

  def preorder(node = @root, results = [], &block)
    return if node.nil?         # => base condition
  
    results << block.call(node.data) if block_given?
    results << node.data unless block_given?
    preorder(node.left, results, &block)
    preorder(node.right, results, &block)
  
    results
  end 

  def inorder(node = @root, results = [], &block)
    return if node.nil?         # => base condition
    
    inorder(node.left, results, &block)
    results << block.call(node.data) if block_given?
    results << node.data unless block_given?
    inorder(node.right, results, &block)
  
    results
  end 

  def postorder(node = @root, results = [], &block)
    return if node.nil?         # => base condition
    
    postorder(node.left, results, &block)
    postorder(node.right, results, &block)
    results << block.call(node.data) if block_given?
    results << node.data unless block_given?

    results
  end 

  def height(node, height_val = 0)
    return height_val - 1 if node.nil?  # => base condition, and avoids adding nil nodes to height

    height_l = height(node.left, height_val + 1)
    height_r = height(node.right, height_val + 1)

    height_l > height_r ? height_l : height_r
  end 

  def depth(node, depth_val = 0, start = @root)
    return nil if start.nil? || node.nil? # => base condition

    if node.data > start.data
      depth(node, depth_val + 1, start.right)
    elsif node.data < start.data
      depth(node, depth_val + 1, start.left)
    else # => we found the node
      return depth_val
    end 
  end 

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    return (left_height - right_height).abs <= 1 && 
      balanced?(node.left) && 
      balanced?(node.right)
  end 

  def rebalance
    array = self.inorder
    build_tree(array)
  end 

  attr_accessor :arr, :root
end 