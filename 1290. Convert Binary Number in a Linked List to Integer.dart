// Given head which is a reference node to a singly-linked list.
// The value of each node in the linked list is either 0 or 1.
// The linked list holds the binary representation of a number.
// Return the decimal value of the number in the linked list.
// The most significant bit is at the head of the linked list.

// Example 1:
// Input: head = [1,0,1]
// Output: 5
// Explanation: (101) in base 2 = (5) in base 10

// Example 2:
// Input: head = [0]
// Output: 0

// Constraints:
// The Linked List is not empty.
// Number of nodes will not exceed 30.
// Each node's value is either 0 or 1.

import 'list_node.dart';
import 'testable.dart';

class Solution {
  int getDecimalValue(ListNode? head) {
    var result = 0;

    ListNode? pointer = head;

    while (pointer != null) {
      result |= pointer.val;

      if (pointer.next != null) {
        result <<= 1;
      }

      pointer = pointer.next;
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.head, required super.result});

  final ListNode? head;

  @override
  int computeResult() => Solution().getDecimalValue(head);
}

void main(List<String> args) {
  [
    SolutionTest(head: [1, 0, 1].toListNode(), result: 5),
    SolutionTest(head: <int>[].toListNode(), result: 0),
    SolutionTest(head: [0, 0, 0].toListNode(), result: 0),
    SolutionTest(head: [0, 1, 0].toListNode(), result: 2),
  ].test();
}

extension ListToListNodeExtension on List<int> {
  ListNode? toListNode() {
    if (this.isEmpty) return null;

    final startNode = ListNode(this.first);

    ListNode? currentListNode = startNode;

    for (var i = 1; i < this.length; i++) {
      currentListNode?.next = ListNode(this[i]);
      currentListNode = currentListNode?.next;
    }

    return startNode;
  }
}
