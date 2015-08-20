class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end
end



# @param {ListNode} l1

# @param {ListNode} l2

# @return {ListNode}

#def add_two_numbers(l1, l2)
  #a1 = list_to_a(l1)
  #a2 = list_to_a(l2)
  #a3 = a1.length > a2.length ? a1.zip(a2) : a2.zip(a1)
  #rs = a3.map.with_index{ |arr, index| (arr.first.to_i + arr.last.to_i) * (10 ** index) }.inject(0) { |sum, i| sum + i }
  #create_list rs
#end

#def create_list val
  #node  = ListNode.new val % 10
  #node.next = create_list val / 10 if val > 10
  #node
#end

#def list_to_a list
  #rs = []
  #until list.nil?
    #rs << list.val
    #list = list.next
  #end
  #rs
#end


def add_two_numbers l1, l2
    sum = 0

    root_n = ListNode.new 0

    next_n = root_n

    until(l1.nil? && l2.nil?)

        sum = sum / 10

        l1 ||= ListNode.new 0

        l2 ||= ListNode.new 0

        sum += l1.val + l2.val

        next_n.next = ListNode.new sum % 10

        l1 = l1.next

        l2 = l2.next

        next_n = next_n.next

    end
    if sum / 10 == 1
      next_n.next = ListNode.new 1
    end

    root_n.next
end


def array_to_list ary
  root = ListNode.new ary.pop
  root.tap do |node|
    until ary.empty?
      node.next = ListNode.new ary.pop
      node = node.next
    end
  end
end


def main ar1, ar2
  add_two_numbers array_to_list(ar1), array_to_list(ar2)
end

#p main([0], [0])
#p main([0], [1])
#p main([0], [7, 3])
p main([5], [5])
