// Given the head of a singly linked list, return true if it is a
//
// or false otherwise.
//
// Example 1:
// Input: head = [1,2,2,1]
// Output: true
//
// Example 2:
// Input: head = [1,2]
// Output: false
//
// Constraints:
//     The number of nodes in the list is in the range [1, 105].
//     0 <= Node.val <= 9
//
// Follow up: Could you do it in O(n) time and O(1) space?

import 'list_node.dart';
import 'testable.dart';

class Solution {
  bool isPalindrome(ListNode? head) {
    if (head == null || head.next == null) return true;

    ListNode? slow = head;
    ListNode? fast = head;
    final stack = <int>[];

    while (fast != null && fast.next != null) {
      stack.add(slow!.val);
      slow = slow.next;
      fast = fast.next!.next;
    }

    if (fast != null) slow = slow!.next;

    while (slow != null) {
      if (stack.removeLast() != slow.val) return false;
      slow = slow.next;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final ListNode? head;
  SolutionTest({required this.head, required super.result});

  @override
  computeResult() => Solution().isPalindrome(head);
}

void main(List<String> args) {
  [
    SolutionTest(head: ListNode.fromList([1, 2, 2, 1]), result: true),
    SolutionTest(head: ListNode.fromList([1, 2]), result: false),
    SolutionTest(head: ListNode.fromList([1, 0, 1]), result: true),
  ].test();
}
