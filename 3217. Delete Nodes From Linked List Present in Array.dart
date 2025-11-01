// You are given an array of integers nums and the head of a linked list. Return the head of the modified linked list after removing all nodes from the linked list that have a value that exists in nums.
//
// Example 1:
// Input: nums = [1,2,3], head = [1,2,3,4,5]
// Output: [4,5]
// Explanation:
// Remove the nodes with values 1, 2, and 3.
//
// Example 2:
// Input: nums = [1], head = [1,2,1,2,1,2]
// Output: [2,2,2]
// Explanation:
// Remove the nodes with value 1.
//
// Example 3:
// Input: nums = [5], head = [1,2,3,4]
// Output: [1,2,3,4]
// Explanation:
// No node has value 5.
//
// Constraints:
// 1 <= nums.length <= 105
// 1 <= nums[i] <= 105
// All elements in nums are unique.
// The number of nodes in the given list is in the range [1, 105].
// 1 <= Node.val <= 105
// The input is generated such that there is at least one node in the linked list that has a value not present in nums.

import 'list_node.dart';
import 'testable.dart';

class Solution {
  ListNode? modifiedList(List<int> nums, ListNode? head) {
    if (head == null) return head;
    final numsSet = nums.toSet();

    while (head != null && numsSet.contains(head.val)) {
      head = head.next;
    }
    if (head == null) return head;

    ListNode? pointer = head;
    while (pointer != null) {
      var next = pointer.next;
      while (next != null && numsSet.contains(next.val)) {
        next = next.next;
      }
      pointer.next = next;
      pointer = next;
    }

    return head;
  }
}

class SolutionTest extends Testable<ListNode?> with ConsoleTestOutput {
  final List<int> nums;
  final ListNode? head;

  SolutionTest({required this.nums, required this.head, required super.result});

  @override
  ListNode? computeResult() => Solution().modifiedList(nums, head);

  @override
  bool validateResult(ListNode? computedResult, ListNode? expectedResult) =>
      computedResult.toString() == expectedResult.toString();
}

void main(List<String> args) {
  [
    SolutionTest(
        nums: [1, 2, 3],
        head: ListNode.fromList([1, 2, 3, 4, 5]),
        result: ListNode.fromList([4, 5])),
    SolutionTest(
        nums: [1],
        head: ListNode.fromList([1, 2, 1, 2, 1, 2]),
        result: ListNode.fromList([2, 2, 2])),
    SolutionTest(
        nums: [5],
        head: ListNode.fromList([1, 2, 3, 4]),
        result: ListNode.fromList([1, 2, 3, 4])),
  ].test();
}
