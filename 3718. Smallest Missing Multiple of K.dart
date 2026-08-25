// Given an integer array nums and an integer k, return the smallest positive multiple of k that is missing from nums.
//
// A multiple of k is any positive integer divisible by k.
//
// Example 1:
// Input: nums = [8,2,3,4,6], k = 2
// Output: 10
// Explanation:
// The multiples of k = 2 are 2, 4, 6, 8, 10, 12... and the smallest multiple missing from nums is 10.
//
// Example 2:
// Input: nums = [1,4,7,10,15], k = 5
// Output: 5
//
// Explanation:
// The multiples of k = 5 are 5, 10, 15, 20... and the smallest multiple missing from nums is 5.
//
// Constraints:
// 1 <= nums.length <= 100
// 1 <= nums[i] <= 100
// 1 <= k <= 100

import 'testable.dart';

class Solution {
  int missingMultiple(List<int> nums, int k) {
    final seen = nums.toSet();

    for (var multiple = k; ; multiple += k) {
      if (!seen.contains(multiple)) {
        return multiple;
      }
    }
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  new({required this.nums, required this.k, required super.result});

  @override
  int computeResult() => Solution().missingMultiple(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [8, 2, 3, 4, 6], k: 2, result: 10),
    SolutionTest(nums: [1, 4, 7, 10, 15], k: 5, result: 5),
  ].test();
}
