// Given the head of a singly linked list, return the middle node of the linked list.
// If there are two middle nodes, return the second middle node.
//
// Example 1:
// Input: head = [1,2,3,4,5]
// Output: [3,4,5]
// Explanation: The middle node of the list is node 3.
//
// Example 2:
// Input: head = [1,2,3,4,5,6]
// Output: [4,5,6]
// Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.
//
// Constraints:
//     The number of nodes in the list is in the range [1, 100].
//     1 <= Node.val <= 100

import 'list_node.dart';
import 'testable.dart';

class Solution {
  ListNode? middleNode(ListNode? head) {
    var fastPointer = head?.next;

    while (fastPointer != null) {
      fastPointer = fastPointer.next?.next;
      head = head?.next;
    }

    return head;
  }
}

class SolutionTest extends Testable<ListNode?> with ConsoleTestOutput {
  final ListNode? head;

  SolutionTest({required this.head, required super.result});

  @override
  computeResult() => Solution().middleNode(head);

  @override
  bool validateResult(ListNode? computedResult, ListNode? expectedResult) {
    while (computedResult != null && expectedResult != null) {
      if (computedResult.val != expectedResult.val) return false;

      computedResult = computedResult.next;
      expectedResult = expectedResult.next;
    }

    return true;
  }
}

void main(List<String> args) {
  [
    SolutionTest(
        head: ListNode.fromList([1, 2, 3, 4, 5]),
        result: ListNode.fromList([3, 4, 5])),
    SolutionTest(
        head: ListNode.fromList([1, 2, 3, 4, 5, 6]),
        result: ListNode.fromList([4, 5, 6]))
  ].test();
}
