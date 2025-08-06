// Given two 0-indexed integer arrays nums1 and nums2, return a list answer of size 2 where:
//     answer[0] is a list of all distinct integers in nums1 which are not present in nums2.
//     answer[1] is a list of all distinct integers in nums2 which are not present in nums1.
// Note that the integers in the lists may be returned in any order.

// Example 1:
// Input: nums1 = [1,2,3], nums2 = [2,4,6]
// Output: [[1,3],[4,6]]
// Explanation:
// For nums1, nums1[1] = 2 is present at index 0 of nums2, whereas nums1[0] = 1 and nums1[2] = 3 are not present in nums2. Therefore, answer[0] = [1,3].
// For nums2, nums2[0] = 2 is present at index 1 of nums1, whereas nums2[1] = 4 and nums2[2] = 6 are not present in nums1. Therefore, answer[1] = [4,6].

// Example 2:
// Input: nums1 = [1,2,3,3], nums2 = [1,1,2,2]
// Output: [[3],[]]
// Explanation:
// For nums1, nums1[2] and nums1[3] are not present in nums2. Since nums1[2] == nums1[3], their value is only included once and answer[0] = [3].
// Every integer in nums2 is present in nums1. Therefore, answer[1] = [].

// Constraints:
//     1 <= nums1.length, nums2.length <= 1000
//     -1000 <= nums1[i], nums2[i] <= 1000

import 'testable.dart';

class Solution {
  List<List<int>> findDifference(List<int> nums1, List<int> nums2) {
    final num1FreqMap = {for (final num in nums1) num: 0};
    nums2.forEach((num) => num1FreqMap[num] = (num1FreqMap[num] ?? 0) + 1);

    final num2FreqMap = {for (final num in nums2) num: 0};
    nums1.forEach((num) => num2FreqMap[num] = (num2FreqMap[num] ?? 0) + 1);

    final nums1Distinct =
        num1FreqMap.keys.where((key) => num1FreqMap[key] == 0).toList();

    final nums2Distinct =
        num2FreqMap.keys.where((key) => num2FreqMap[key] == 0).toList();

    return [nums1Distinct, nums2Distinct];
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  SolutionTest({
    required this.nums1,
    required this.nums2,
    required super.result,
  });

  final List<int> nums1;
  final List<int> nums2;

  @override
  List<List<int>> computeResult() => Solution().findDifference(nums1, nums2);
}

void main(List<String> args) {
  [
    SolutionTest(nums1: [1,2,3], nums2: [2,4,6],result: [[1, 3],[4, 6]]),
    SolutionTest(nums1: [1,2,3,3], nums2: [1,1,2,2],result: [[3],[]])
  ].test();
}
