// Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.
//
// Example 1:
// Input: nums1 = [1,2,2,1], nums2 = [2,2]
// Output: [2,2]
// Example 2:
//
// Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
// Output: [4,9]
// Explanation: [9,4] is also accepted.
//
//
// Constraints:
//
// 1 <= nums1.length, nums2.length <= 1000
// 0 <= nums1[i], nums2[i] <= 1000

import 'testable.dart';

class Solution {
  List<int> intersect(List<int> nums1, List<int> nums2) {
    final freq1 = <int, int>{};
    for (final number in nums1) {
      freq1[number] = (freq1[number] ?? 0) + 1;
    }

    final freq2 = <int, int>{};
    for (final number in nums2) {
      freq2[number] = (freq2[number] ?? 0) + 1;
    }

    final smallestMap = freq1.length > freq2.length ? freq2 : freq1;
    final result = <int>[];
    for (final key in smallestMap.keys) {
      final count1 = freq1[key];
      final count2 = freq2[key];

      if (count1 != null && count2 != null) {
        final minimal = count1 > count2 ? count2 : count1;
        result.addAll(List.filled(minimal, key));
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums1, nums2;

  SolutionTest(
      {required this.nums1, required this.nums2, required super.result});

  @override
  List<int> computeResult() => Solution().intersect(nums1, nums2);

  @override
  bool validateResult(List<int> computedResult, List<int> expectedResult) {
    final computedResultFreq = <int, int>{};
    for (final number in computedResult) {
      computedResultFreq[number] = (computedResultFreq[number] ?? 0) + 1;
    }

    final expectedResultFreq = <int, int>{};
    for (final number in expectedResult) {
      expectedResultFreq[number] = (expectedResultFreq[number] ?? 0) + 1;
    }

    if (computedResultFreq.length != expectedResultFreq.length) return false;

    for (final key in computedResultFreq.keys) {
      if (computedResultFreq[key] != expectedResultFreq[key]) return false;
    }

    return true;
  }
}

void main(List<String> args) {
  [
    SolutionTest(nums1: [1, 2, 2, 1], nums2: [2, 2], result: [2, 2]),
    SolutionTest(nums1: [4, 9, 5], nums2: [9, 4, 9, 8, 4], result: [4, 9]),
  ].test();
}
