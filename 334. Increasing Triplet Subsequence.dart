// Given an integer array nums,
// return true if there exists a triple of indices (i, j, k)
// such that i < j < k and nums[i] < nums[j] < nums[k].
// If no such indices exists, return false.

// Example 1:
// Input: nums = [1,2,3,4,5]
// Output: true
// Explanation: Any triplet where i < j < k is valid.

// Example 2:
// Input: nums = [5,4,3,2,1]
// Output: false
// Explanation: No triplet exists.

// Example 3:
// Input: nums = [2,1,5,0,4,6]
// Output: true
// Explanation: The triplet (3, 4, 5) is valid because
// nums[3] == 0 < nums[4] == 4 < nums[5] == 6.

// Constraints:
//     1 <= nums.length <= 5 * 105
//     -231 <= nums[i] <= 231 - 1

// Follow up: Could you implement a solution that runs
// in O(n) time complexity and O(1) space complexity?

import 'testable.dart';

class Solution {
  bool increasingTriplet(List<int> nums) {
    int? i, j;

    for (var num in nums) {
      if (i == null || i >= num) {
        i = num;
      } else if (j == null || j >= num) {
        j = num;
      } else {
        return true;
      }
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  bool computeResult() => Solution().increasingTriplet(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 0, 3], result: false),
    SolutionTest(nums: [1, 2, 3, 4, 5], result: true),
    SolutionTest(nums: [5, 4, 3, 2, 1], result: false),
    SolutionTest(nums: [2, 1, 5, 0, 4, 6], result: true),
    SolutionTest(nums: [1, 5, 0, 4, 1, 3], result: true),
    SolutionTest(nums: [20, 100, 10, 12, 5, 13], result: true),
    SolutionTest(nums: [1], result: false),
    SolutionTest(nums: [0, 4, 2, 1, 0, -1, -3], result: false),
  ].test();
}
