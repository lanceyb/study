require "minitest/autorun"

Node = Struct.new(:data, :lchild, :rchild, :parent) do
  def <=> n
    self.data <=> n.data
  end
end
Node.send :include, Comparable

class BinaryTree
  attr_reader :nodes, :root

  def initialize
    @nodes = []
  end

  def init_tree root
    raise "not blank tree" if @nodes.length > 0

    @root = root
    @nodes.push(root)
  end

  def insert_left node, parent
    insert node, parent, :left
  end

  def insert_right node, parent
    insert node, parent, :right
  end

  def insert node, parent, flag = :left
    parent_node = find(parent)
    return false if parent_node.nil?
    return false unless find(node).nil?

    if flag == :left
      return false if parent_node.lchild.nil?
      parent_node.lchild = node
    else
      return false if parent_node.rchild.nil?
      parent_node.rchild = node
    end
    node.parent = parent_node
    @nodes.push node
  end

  def find node
    @nodes.find { |n| n == node }
  end

  def delete node
    node = @nodes.delete(node)
    return nil if node.nil?

    if node.parent.lchild == node
      node.parent.lchild = nil
    else
      node.parent.rchild = nil
    end
    node
  end

  def depth node
    node = find(node)
    return 0 if node.nil?

    ldepth = depth(node.lchild)
    rdepth = depth(node.rchild)

    if ldepth != 0 and rdepth != 0
      ldepth > rdepth ? ldepth : rdepth
    else
      ldepth + rdepth
    end + 1
  end

  def tree_depth
    depth root
  end
end

class BinaryTreeTest < MiniTest::Test
  def setup
    @binary_tree = BinaryTree.new
  end

  def test_node_eql
    n1 = Node.new("12")
    n2 = Node.new("12")
    assert_equal n1, n2
  end

  def test_blank_tree
    assert_equal 0, @binary_tree.nodes.length
    assert_nil @binary_tree.root
  end

  def test_init_tree
    root = Node.new("12")
    @binary_tree.init_tree root
    assert_equal root, @binary_tree.root
    assert_equal 1, @binary_tree.nodes.length
  end

  def test_insert_left
    root = Node.new("12")
    @binary_tree.init_tree root

    node = Node.new("234")
    assert @binary_tree.insert_left(node, @binary_tree.root)
    assert !@binary_tree.insert_left(Node.new("abc"), Node.new("invalid parent"))
    assert_equal node, @binary_tree.root.lchild
  end

  def test_insert_right
    root = Node.new("12")
    @binary_tree.init_tree root

    node = Node.new("234")
    assert @binary_tree.insert_right(node, @binary_tree.root)
    assert !@binary_tree.insert_right(Node.new("abc"), Node.new("invalid parent"))
    assert_equal node, @binary_tree.root.rchild
  end

  def test_find
    @binary_tree.init_tree Node.new("12")
    @binary_tree.insert_left Node.new("23"), @binary_tree.root

    node = Node.new "23"
    assert_equal node, @binary_tree.find(node)
  end

  def test_depth
    @binary_tree.init_tree Node.new("12")
    @binary_tree.insert_left Node.new("23"), @binary_tree.root

    assert_equal 0, @binary_tree.depth(Node.new("34"))
    assert_equal 1, @binary_tree.depth(Node.new("23"))
    assert_equal 2, @binary_tree.depth(Node.new("12"))
  end

  def test_delete
    @binary_tree.init_tree Node.new("12")
    @binary_tree.insert_left Node.new("23"), @binary_tree.root

    assert_nil @binary_tree.delete(Node.new("34"))

    node = @binary_tree.find(Node.new("23"))
    parent = @binary_tree.find(node.parent)

    assert_equal parent.lchild, node
    assert_equal node, @binary_tree.delete(node)
    assert_equal nil, @binary_tree.find(parent).lchild
  end
end
