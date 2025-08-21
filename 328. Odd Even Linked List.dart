// Given the head of a singly linked list,
// group all the nodes with odd indices together followed by the nodes
// with even indices, and return the reordered list.
// The first node is considered odd, and the second node is even, and so on.
// Note that the relative order inside both the even and odd groups
// should remain as it was in the input.
// You must solve the problem in O(1) extra space complexity
// and O(n) time complexity.

// Example 1:
// Input: head = [1,2,3,4,5]
// Output: [1,3,5,2,4]

// Example 2:
// Input: head = [2,1,3,5,6,4,7]
// Output: [2,3,6,7,1,5,4]

// Constraints:
//     The number of nodes in the linked list is in the range [0, 104].
//     -106 <= Node.val <= 106

// Definition for singly-linked list.
import 'testable.dart';

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

extension ListNodeExtension on ListNode? {
  List<int> toList() {
    final result = <int>[];
    ListNode? current = this;
    while (current != null) {
      result.add(current.val);
      current = current.next;
    }
    return result;
  }

  static ListNode? fromList(List<int> list) {
    if (list.isEmpty) return null;

    final head = ListNode(list.first);
    ListNode? current = head;
    for (int i = 1; i < list.length; i++) {
      current?.next = ListNode(list[i]);
      current = current?.next;
    }
    return head;
  }
}

class Solution {
  ListNode? oddEvenList(ListNode? head) {
    if (head == null || head.next == null) return head;

    final evenHeadStart = head.next;

    ListNode? oddHead = head;
    ListNode? evenHead = head.next;

    while (evenHead?.next != null) {
      oddHead?.next = evenHead?.next;
      oddHead = oddHead?.next;
      evenHead?.next = oddHead?.next;
      evenHead = evenHead?.next;
    }

    oddHead?.next = evenHeadStart;

    return head;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  SolutionTest({required this.linkedList, required super.result});

  final List<int> linkedList;

  @override
  List<int> computeResult() =>
      Solution().oddEvenList(ListNodeExtension.fromList(linkedList)).toList();
}

void main(List<String> args) {
  [
    SolutionTest(linkedList: [1, 2, 3, 4, 5, 6], result: [1, 3, 5, 2, 4, 6]),
    SolutionTest(
        linkedList: [2, 1, 3, 5, 6, 4, 7], result: [2, 3, 6, 7, 1, 5, 4])
  ].test();
}
