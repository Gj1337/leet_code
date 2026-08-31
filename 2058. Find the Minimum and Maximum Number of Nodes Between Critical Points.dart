// A critical point in a linked list is defined as either a local maxima or a local minima.
// A node is a local maxima if the current node has a value strictly greater than the previous node and the next node.
// A node is a local minima if the current node has a value strictly smaller than the previous node and the next node.
// Note that a node can only be a local maxima/minima if there exists both a previous node and a next node.
// Given a linked list head, return an array of length 2 containing [minDistance, maxDistance] where minDistance is the minimum distance between any two distinct critical points and maxDistance is the maximum distance between any two distinct critical points. If there are fewer than two critical points, return [-1, -1].
//
// Example 1:
// Input: head = [3,1]
// Output: [-1,-1]
// Explanation: There are no critical points in [3,1].
//
// Example 2:
// Input: head = [5,3,1,2,5,1,2]
// Output: [1,3]
// Explanation: There are three critical points:
// - [5,3,1,2,5,1,2]: The third node is a local minima because 1 is less than 3 and 2.
// - [5,3,1,2,5,1,2]: The fifth node is a local maxima because 5 is greater than 2 and 1.
// - [5,3,1,2,5,1,2]: The sixth node is a local minima because 1 is less than 5 and 2.
// The minimum distance is between the fifth and the sixth node. minDistance = 6 - 5 = 1.
// The maximum distance is between the third and the sixth node. maxDistance = 6 - 3 = 3.
//
// Example 3:
// Input: head = [1,3,2,2,3,2,2,2,7]
// Output: [3,3]
// Explanation: There are two critical points:
// - [1,3,2,2,3,2,2,2,7]: The second node is a local maxima because 3 is greater than 1 and 2.
// - [1,3,2,2,3,2,2,2,7]: The fifth node is a local maxima because 3 is greater than 2 and 2.
// Both the minimum and maximum distances are between the second and the fifth node.
// Thus, minDistance and maxDistance is 5 - 2 = 3.
// Note that the last node is not considered a local maxima because it does not have a next node.
//
// Constraints:
// The number of nodes in the list is in the range [2, 105].
// 1 <= Node.val <= 105

import 'list_node.dart';
import 'testable.dart';

class Solution {
  List<int> nodesBetweenCriticalPoints(ListNode? head) {
    if (head == null) return [-1, -1];

    var currentIndex = 0;

    var minDistance = -1;
    int? firstPointIndex;
    int? currentPointIndex;
    var currentNode = head;
    var nextNode = head.next;

    while (nextNode?.next != null) {
      currentIndex += 1;

      final isMinimum =
          currentNode.val > nextNode!.val && nextNode.val < nextNode.next!.val;
      final isMaximum =
          currentNode.val < nextNode.val && nextNode.val > nextNode.next!.val;

      if (isMinimum || isMaximum) {
        firstPointIndex ??= currentIndex;

        if (currentPointIndex != null) {
          final distance = currentIndex - currentPointIndex;
          minDistance = minDistance == -1 || distance < minDistance
              ? distance
              : minDistance;
        }

        currentPointIndex = currentIndex;
      }

      currentNode = nextNode;
      nextNode = nextNode.next;
    }

    final maxDistance =
        firstPointIndex == currentPointIndex || currentPointIndex == null
        ? -1
        : currentPointIndex - firstPointIndex!;

    return [minDistance, maxDistance];
  }
}

// Solution that uses recursion,
//
// class Solution {
//   List<int> nodesBetweenCriticalPoints(ListNode? head) {
//     if (head == null) return [-1, -1];
//
//     var currentIndex = 0;
//
//     var minDistance = -1;
//     int? firstPointIndex;
//     int? currentPointIndex;
//
//     void traverse(ListNode? preNode, ListNode currentNode) {
//       currentIndex += 1;
//
//       final nextNode = currentNode.next;
//
//       if (nextNode == null) {
//         return;
//       } else if (preNode != null) {
//         final isMinimum =
//             preNode.val > currentNode.val && currentNode.val < nextNode.val;
//         final isMaximum =
//             preNode.val < currentNode.val && currentNode.val > nextNode.val;
//
//         if (isMinimum || isMaximum) {
//           firstPointIndex ??= currentIndex;
//
//           if (currentPointIndex != null) {
//             final distance = currentIndex - currentPointIndex!;
//             minDistance = minDistance == -1 || distance < minDistance
//                 ? distance
//                 : minDistance;
//           }
//
//           currentPointIndex = currentIndex;
//         }
//       }
//
//       traverse(currentNode, nextNode);
//     }
//
//     traverse(null, head);
//
//     final maxDistance =
//         firstPointIndex == currentPointIndex || currentPointIndex == null
//         ? -1
//         : currentPointIndex! - firstPointIndex!;
//
//     return [minDistance, maxDistance];
//   }
// }

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final ListNode? head;

  SolutionTest({required this.head, required super.result});

  @override
  List<int> computeResult() => Solution().nodesBetweenCriticalPoints(head);
}

void main(List<String> args) {
  [
    SolutionTest(head: ListNode.fromList([3, 1]), result: [-1, -1]),
    SolutionTest(
      head: ListNode.fromList([5, 3, 1, 2, 5, 1, 2]),
      result: [1, 3],
    ),
    SolutionTest(
      head: ListNode.fromList([1, 3, 2, 2, 3, 2, 2, 2, 7]),
      result: [3, 3],
    ),
  ].test();
}
