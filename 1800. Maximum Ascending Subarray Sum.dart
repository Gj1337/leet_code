// Given an array of positive integers nums,
// return the maximum possible sum of an ascending subarray in nums.
// A subarray is defined as a contiguous sequence of numbers in an array.
// A subarray [numsl, numsl+1, ..., numsr-1, numsr] is ascending if
// for all i where l <= i < r, numsi  < numsi+1.
// Note that a subarray of size 1 is ascending.

// Example 1:
// Input: nums = [10,20,30,5,10,50]
// Output: 65
// Explanation: [5,10,50] is the ascending subarray
// with the maximum sum of 65.

// Example 2:
// Input: nums = [10,20,30,40,50]
// Output: 150
// Explanation: [10,20,30,40,50] is the ascending subarray
// with the maximum sum of 150.

// Example 3:
// Input: nums = [12,17,15,13,10,11,12]
// Output: 33
// Explanation: [10,11,12] is the ascending subarray
// with the maximum sum of 33.

// Constraints:
//     1 <= nums.length <= 100
//     1 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  int maxAscendingSum(List<int> nums) {
    if (nums.isEmpty) return 0;

    var maxSum = nums[0];
    var currentMasSum = nums[0];

    for (var i = 0; i < nums.length - 1; i++) {
      currentMasSum =
          nums[i] < nums[i + 1] ? currentMasSum + nums[i + 1] : nums[i + 1];

      maxSum = _max(currentMasSum, maxSum);
    }

    return maxSum;
  }

  int _max(int a, int b) => a > b ? a : b;
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required super.result,
  });

  final List<int> nums;

  @override
  int computeResult() => Solution().maxAscendingSum(nums);
}

void main(List<String> args) {
  [
    SolutionTest(
      nums: [10, 20, 30, 5, 10, 50],
      result: 65,
    ),
    SolutionTest(
      nums: [10, 20, 30, 40, 50],
      result: 150,
    ),
    SolutionTest(
      nums: [12, 17, 15, 13, 10, 11, 12],
      result: 33,
    ),
    SolutionTest(
      nums: [100, 10, 1],
      result: 100,
    ),
    SolutionTest(
      nums: [10, 100, 1],
      result: 110,
    ),
    SolutionTest(
      nums: [10, 1, 100],
      result: 101,
    ),
    SolutionTest(
      nums: [3, 6, 10, 1, 8, 9, 9, 8, 9],
      result: 19,
    )
  ].test();
}
