// You are given the head of a linked list.
// Remove every node which has a node with a greater value anywhere to the right side of it.
// Return the head of the modified linked list.
//
// Example 1:
// Input: head = [5,2,13,3,8]
// Output: [13,8]
// Explanation: The nodes that should be removed are 5, 2 and 3.
// - Node 13 is to the right of node 5.
// - Node 13 is to the right of node 2.
// - Node 8 is to the right of node 3.
//
// Example 2:
// Input: head = [1,1,1,1]
// Output: [1,1,1,1]
// Explanation: Every node has value 1, so no nodes are removed.
//
// Constraints:
// The number of the nodes in the given list is in the range [1, 105].
// 1 <= Node.val <= 105

import 'list_node.dart';
import 'testable.dart';

class Solution {
  ListNode? removeNodes(ListNode? head) {
    ListNode? invertList(ListNode? head) {
      var first = head;
      var second = head?.next;
      var third = head?.next?.next;
      head?.next = null;

      while (second != null) {
        second.next = first;
        first = second;
        second = third;
        third = third?.next;
      }

      return first;
    }

    final inversedHead = invertList(head);
    ListNode? pointer = inversedHead;

    while (pointer != null) {
      ListNode? next = pointer.next;
      while (next != null && next.val < pointer.val) {
        next = next.next;
      }
      pointer.next = next;
      pointer = next;
    }

    return invertList(inversedHead);
  }
}

class SolutionTest extends Testable<ListNode?> with ConsoleTestOutput {
  final ListNode? head;

  SolutionTest({required this.head, required super.result});

  @override
  ListNode? computeResult() => Solution().removeNodes(head);

  @override
  bool validateResult(ListNode? computedResult, ListNode? expectedResult) =>
      computedResult.toString() == expectedResult.toString();
}

void main(List<String> args) {
  [
    SolutionTest(
        head: ListNode.fromList([5, 2, 13, 3, 8]),
        result: ListNode.fromList([13, 8])),
    SolutionTest(
        head: ListNode.fromList([1, 1, 1, 1]),
        result: ListNode.fromList([1, 1, 1, 1])),
  ].test();
}
