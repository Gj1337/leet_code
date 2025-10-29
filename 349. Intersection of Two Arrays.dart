// Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.
//
// Example 1:
// Input: nums1 = [1,2,2,1], nums2 = [2,2]
// Output: [2]
//
// Example 2:
// Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
// Output: [9,4]
// Explanation: [4,9] is also accepted.
//
// Constraints:
// 1 <= nums1.length, nums2.length <= 1000
// 0 <= nums1[i], nums2[i] <= 1000

import 'testable.dart';

class Solution {
  List<int> intersection(List<int> nums1, List<int> nums2) {
    final nums1Set = nums1.toSet();
    final nums2Set = nums2.toSet();

    final result = <int>[];

    for (var element in nums1Set) {
      if (nums2Set.contains(element)) result.add(element);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums1;
  final List<int> nums2;

  SolutionTest({
    required this.nums1,
    required this.nums2,
    required super.result,
  });

  @override
  List<int> computeResult() => Solution().intersection(nums1, nums2);
}

void main(List<String> args) {
  [
    SolutionTest(nums1: [1, 2, 2, 1], nums2: [2, 2], result: [2]),
    SolutionTest(nums1: [4, 9, 5], nums2: [9, 4, 9, 8, 4], result: [4, 9]),
  ].test();
}
