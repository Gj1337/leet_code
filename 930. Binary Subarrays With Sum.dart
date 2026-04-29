// Given a binary array nums and an integer goal, return the number of non-empty subarrays with a sum goal.

// A subarray is a contiguous part of the array.

// Example 1:
// Input: nums = [1,0,1,0,1], goal = 2
// Output: 4
// Explanation: The 4 subarrays are bolded and underlined below:
// [1,0,1,0,1]
// [1,0,1,0,1]
// [1,0,1,0,1]
// [1,0,1,0,1]

// Example 2:
// Input: nums = [0,0,0,0,0], goal = 0
// Output: 15

// Constraints:
// 1 <= nums.length <= 3 * 104
// nums[i] is either 0 or 1.
// 0 <= goal <= nums.length

import 'testable.dart';

class Solution {
  int numSubarraysWithSum(List<int> nums, int goal) {
    final prefixSum = <int, int>{0: 1};

    var currentSum = 0;
    var totalCount = 0;

    for (final num in nums) {
      currentSum += num;
      totalCount += prefixSum[currentSum - goal] ?? 0;
      prefixSum[currentSum] = (prefixSum[currentSum] ?? 0) + 1;
    }

    return totalCount;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int goal;

  SolutionTest({required this.nums, required this.goal, required super.result});

  @override
  int computeResult() => Solution().numSubarraysWithSum(nums, goal);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 0, 1, 0, 1], goal: 2, result: 4),
    SolutionTest(nums: [0, 0, 0, 0, 0], goal: 0, result: 15),
  ].test();
}
