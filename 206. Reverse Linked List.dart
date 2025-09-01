// Given the head of a singly linked list, reverse the list,
// and return the reversed list.

// Example 1:
// Input: head = [1,2,3,4,5]
// Output: [5,4,3,2,1]

// Example 2:
// Input: head = [1,2]
// Output: [2,1]

// Example 3:
// Input: head = []
// Output: []

// Constraints:
//     The number of nodes in the list is the range [0, 5000].

// Definition for singly-linked list.
import 'list_node.dart';
import 'testable.dart';

class Solution {
  ListNode? reverseList(ListNode? head) {
    if (head == null) return head;
    if (head.next == null) return head;

    var next = head.next?.next;
    var current = head.next;
    var previouis = head;

    head.next = null;

    while (current != null) {
      current.next = previouis;
      previouis = current;
      current = next;
      next = next?.next;
    }

    return previouis;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> linkedList;

  SolutionTest({required this.linkedList, required super.result});

  @override
  List<int> computeResult() {
    final head = ListNode.fromList(linkedList);
    final reversedHead = Solution().reverseList(head);

    return reversedHead?.toList() ?? [];
  }
}

void main(List<String> args) {
  [
    SolutionTest(linkedList: [1, 2, 3, 4, 5], result: [5, 4, 3, 2, 1]),
    SolutionTest(linkedList: [1, 2], result: [2, 1])
  ].test();
}
