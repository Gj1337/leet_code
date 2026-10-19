// You are given a 0-indexed integer array nums and a target element target.
// A target index is an index i such that nums[i] == target.
// Return a list of the target indices of nums after sorting nums in non-decreasing order. If there are no target indices, return an empty list. The returned list must be sorted in increasing order.
//
// Example 1:
// Input: nums = [1,2,5,2,3], target = 2
// Output: [1,2]
// Explanation: After sorting, nums is [1,2,2,3,5].
// The indices where nums[i] == 2 are 1 and 2.
//
// Example 2:
// Input: nums = [1,2,5,2,3], target = 3
// Output: [3]
// Explanation: After sorting, nums is [1,2,2,3,5].
// The index where nums[i] == 3 is 3.
//
// Example 3:
// Input: nums = [1,2,5,2,3], target = 5
// Output: [4]
// Explanation: After sorting, nums is [1,2,2,3,5].
// The index where nums[i] == 5 is 4.
//
// Constraints:
// 1 <= nums.length <= 100
// 1 <= nums[i], target <= 100

import 'testable.dart';

class Solution {
  List<int> targetIndices(List<int> nums, int target) {
    int numberBeforeTarget = 0, numberOfTargets = 0;

    for (final number in nums) {
      if (number == target) numberOfTargets += 1;
      if (number < target) numberBeforeTarget += 1;
    }

    return List.generate(numberOfTargets, (i) => numberBeforeTarget + i);
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums;
  final int target;

  SolutionTest({
    required this.nums,
    required this.target,
    required super.result,
  });

  @override
  List<int> computeResult() => Solution().targetIndices(nums, target);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 5, 2, 3], target: 3, result: [3]),
  ].test();
}
