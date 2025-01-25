// Given an array of positive integers nums and a positive integer target, return the minimal length of a
// subarray
//  whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.

// Example 1:

// Input: target = 7, nums = [2,3,1,2,4,3]
// Output: 2
// Explanation: The subarray [4,3] has the minimal length under the problem constraint.
// Example 2:

// Input: target = 4, nums = [1,4,4]
// Output: 1
// Example 3:

// Input: target = 11, nums = [1,1,1,1,1,1,1,1]
// Output: 0

// Constraints:

// 1 <= target <= 109
// 1 <= nums.length <= 105
// 1 <= nums[i] <= 104

import 'testable.dart';

class Solution {
  int minSubArrayLen(int target, List<int> nums) {
    var left = 0, currentSum = 0;
    int? minLenght;

    for (var right = 0; right < nums.length; right++) {
      currentSum += nums[right];

      while (currentSum >= target) {
        minLenght = min(minLenght, right - left + 1);
        if (minLenght == 1) return 1;

        currentSum -= nums[left++];
      }
    }

    return minLenght ?? 0;
  }

  int? min(int? a, int? b) {
    if (a == null || b == null) return a ?? b;
    return a < b ? a : b;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.target,
    required this.nums,
    required super.result,
  });

  final int target;
  final List<int> nums;

  @override
  computeResult() => Solution().minSubArrayLen(target, nums);
}

void main(List<String> args) {
  [
    SolutionTest(target: 7, nums: [2, 3, 1, 2, 4, 3], result: 2),
    SolutionTest(target: 4, nums: [1, 4, 4], result: 1),
    SolutionTest(target: 11, nums: [1, 1, 1, 1, 1, 1, 1, 1], result: 0),
  ].test();
}
