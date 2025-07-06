// Given an integer array nums and an integer k,
// return the number of pairs (i, j) where i < j
// such that |nums[i] - nums[j]| == k.
// The value of |x| is defined as:
//     x if x >= 0.
//     -x if x < 0.

// Example 1:
// Input: nums = [1,2,2,1], k = 1
// Output: 4
// Explanation: The pairs with an absolute difference of 1 are:
// - [1,2,2,1]
// - [1,2,2,1]
// - [1,2,2,1]
// - [1,2,2,1]

// Example 2:
// Input: nums = [1,3], k = 3
// Output: 0
// Explanation: There are no pairs with an absolute difference of 3.

// Example 3:
// Input: nums = [3,2,1,5,4], k = 2
// Output: 3
// Explanation: The pairs with an absolute difference of 2 are:
// - [3,2,1,5,4]
// - [3,2,1,5,4]
// - [3,2,1,5,4]

import 'testable.dart';

class Solution {
  int countKDifference(List<int> nums, int k) {
    var result = 0;

    for (var i = 0; i < nums.length; i++) {
      for (var j = i + 1; j < nums.length; j++) {
        if ((nums[i] - nums[j]).abs() == k) {
          result++;
        }
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.nums, required this.k, required super.result});

  final List<int> nums;
  final int k;

  @override
  int computeResult() => Solution().countKDifference(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 2, 1], k: 1, result: 4),
    SolutionTest(nums: [1, 3], k: 3, result: 0),
    SolutionTest(nums: [3, 2, 1, 5, 4], k: 2, result: 3),

    // 3-1
    // 3-5
    // 2-4
  ].test();
}
