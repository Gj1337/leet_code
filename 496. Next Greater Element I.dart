// The next greater element of some element x in an array is the first greater element that is to the right of x in the same array.
// You are given two distinct 0-indexed integer arrays nums1 and nums2, where nums1 is a subset of nums2.
// For each 0 <= i < nums1.length, find the index j such that nums1[i] == nums2[j] and determine the next greater element of nums2[j] in nums2. If there is no next greater element, then the answer for this query is -1.
// Return an array ans of length nums1.length such that ans[i] is the next greater element as described above.
//
// Example 1:
// Input: nums1 = [4,1,2], nums2 = [1,3,4,2]
// Output: [-1,3,-1]
// Explanation: The next greater element for each value of nums1 is as follows:
// - 4 is underlined in nums2 = [1,3,4,2]. There is no next greater element, so the answer is -1.
// - 1 is underlined in nums2 = [1,3,4,2]. The next greater element is 3.
// - 2 is underlined in nums2 = [1,3,4,2]. There is no next greater element, so the answer is -1.
//
// Example 2:
// Input: nums1 = [2,4], nums2 = [1,2,3,4]
// Output: [3,-1]
// Explanation: The next greater element for each value of nums1 is as follows:
// - 2 is underlined in nums2 = [1,2,3,4]. The next greater element is 3.
// - 4 is underlined in nums2 = [1,2,3,4]. There is no next greater element, so the answer is -1.
//
// Constraints:
// 1 <= nums1.length <= nums2.length <= 1000
// 0 <= nums1[i], nums2[i] <= 104
// All integers in nums1 and nums2 are unique.
// All the integers of nums1 also appear in nums2.
//
// Follow up: Could you find an O(nums1.length + nums2.length) solution?

import 'testable.dart';

class Solution {
  List<int> nextGreaterElement(List<int> nums1, List<int> nums2) {
    final nextGreater = <int, int>{};
    final stack = <int>[];

    for (final num in nums2) {
      while (stack.isNotEmpty && stack.last < num) {
        nextGreater[stack.removeLast()] = num;
      }
      stack.add(num);
    }

    return nums1.map((n) => nextGreater[n] ?? -1).toList();
  }
}

// Brute force solution
//
// class Solution {
//   List<int> nextGreaterElement(List<int> nums1, List<int> nums2) {
//     final result = <int>[];
//
//     for (var i = 0; i < nums1.length; i++) {
//       var addingNumber = -1;
//       var chekingFlag = false;
//
//       for (var j = 0; j < nums2.length; j++) {
//         if (chekingFlag) {
//           if (nums1[i] < nums2[j]) {
//             addingNumber = nums2[j];
//             break;
//           }
//         } else {
//           if (nums1[i] == nums2[j]) chekingFlag = true;
//         }
//       }
//
//       result.add(addingNumber);
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums1;
  final List<int> nums2;

  SolutionTest({
    required this.nums1,
    required this.nums2,
    required super.result,
  });

  @override
  List<int> computeResult() => Solution().nextGreaterElement(nums1, nums2);
}

main() {
  [
    SolutionTest(nums1: [4, 1, 2], nums2: [1, 3, 4, 2], result: [-1, 3, -1]),
    SolutionTest(nums1: [2, 4], nums2: [1, 2, 3, 4], result: [3, -1]),
    SolutionTest(nums1: [4, 1, 2], nums2: [1, 2, 3, 4], result: [-1, 2, 3]),
  ].test();
}
