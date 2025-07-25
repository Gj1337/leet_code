// You are given an integer array nums.
// You are allowed to delete any number of elements from nums
// without making it empty. After performing the deletions, select a
// of nums such that:
//     All elements in the subarray are unique.
//     The sum of the elements in the subarray is maximized.
// Return the maximum sum of such a subarray.

// Example 1:
// Input: nums = [1,2,3,4,5]
// Output: 15
// Explanation:
// Select the entire array without deleting any element
// to obtain the maximum sum.

// Example 2:
// Input: nums = [1,1,0,1,1]
// Output: 1
// Explanation:
// Delete the element nums[0] == 1, nums[1] == 1, nums[2] == 0,
// and nums[3] == 1. Select the entire array [1] to obtain the maximum sum.

// Example 3:
// Input: nums = [1,2,-1,-2,1,0,-1]
// Output: 3
// Explanation:
// Delete the elements nums[2] == -1 and nums[3] == -2,
// and select the subarray [2, 1] from [1, 2, 1, 0, -1]
// to obtain the maximum sum.

// Constraints:
//     1 <= nums.length <= 100
//     -100 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  int maxSum(List<int> nums) {
    nums = nums.toSet().toList()..sort((a,b)=> a < b ? 1 : -1);
    while (nums.last < 0 && nums.length > 1) nums.removeLast();

    return nums.reduce((a, b) => a + b);
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  int computeResult() => Solution().maxSum(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 4, 5], result: 15),
    SolutionTest(nums: [1, 1, 0, 1, 1], result: 1),
    SolutionTest(nums: [1, 2, -1, -2, 1, 0, -1], result: 3),
  ].test();
}
