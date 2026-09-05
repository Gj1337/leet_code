// You are given an integer array nums of length n and an integer k.
// For each index i, define its instability score as max(nums[0..i]) - min(nums[i..n - 1]).
// In other words:
// max(nums[0..i]) is the largest value among the elements from index 0 to index i.
// min(nums[i..n - 1]) is the smallest value among the elements from index i to index n - 1.
// An index i is called stable if its instability score is less than or equal to k.
// Return the smallest stable index. If no such index exists, return -1.
//
// Example 1:
// Input: nums = [5,0,1,4], k = 3
// Output: 3
// Explanation:
// At index 0: The maximum in [5] is 5, and the minimum in [5, 0, 1, 4] is 0, so the instability score is 5 - 0 = 5.
// At index 1: The maximum in [5, 0] is 5, and the minimum in [0, 1, 4] is 0, so the instability score is 5 - 0 = 5.
// At index 2: The maximum in [5, 0, 1] is 5, and the minimum in [1, 4] is 1, so the instability score is 5 - 1 = 4.
// At index 3: The maximum in [5, 0, 1, 4] is 5, and the minimum in [4] is 4, so the instability score is 5 - 4 = 1.
// This is the first index with an instability score less than or equal to k = 3. Thus, the answer is 3.
//
// Example 2:
// Input: nums = [3,2,1], k = 1
// Output: -1
// Explanation:
// At index 0, the instability score is 3 - 1 = 2.
// At index 1, the instability score is 3 - 1 = 2.
// At index 2, the instability score is 3 - 1 = 2.
// None of these values is less than or equal to k = 1, so the answer is -1.
//
// Example 3:
// Input: nums = [0], k = 0
// Output: 0
// Explanation:
// At index 0, the instability score is 0 - 0 = 0, which is less than or equal to k = 0. Therefore, the answer is 0.
//
// Constraints:
// 1 <= nums.length <= 105
// 0 <= nums[i] <= 109
// 0 <= k <= 109

import 'testable.dart';

class Solution {
  int firstStableIndex(List<int> nums, int k) {
    final prefixMax = List.filled(nums.length, 0);
    prefixMax[0] = nums.first;
    for (var i = 1; i < nums.length; i++) {
      prefixMax[i] = prefixMax[i - 1] < nums[i] ? nums[i] : prefixMax[i - 1];
    }

    final suffixMin = List.filled(nums.length, 0);
    suffixMin[nums.length - 1] = nums.last;
    for (var i = nums.length - 2; i >= 0; i--) {
      suffixMin[i] = suffixMin[i + 1] > nums[i] ? nums[i] : suffixMin[i + 1];
    }

    for (var i = 0; i < nums.length; i++) {
      final instabilityScore = prefixMax[i] - suffixMin[i];

      if (instabilityScore <= k) return i;
    }

    return -1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  int computeResult() => Solution().firstStableIndex(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [5, 0, 1, 4], k: 3, result: 3),
    SolutionTest(nums: [3, 2, 1], k: 1, result: -1),
    SolutionTest(nums: [0], k: 0, result: 0),
  ].test();
}
