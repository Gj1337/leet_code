// Given an array of integers nums, you start with an initial positive value startValue.
// In each iteration, you calculate the step by step sum of startValue plus elements in nums (from left to right).
// Return the minimum positive value of startValue such that the step by step sum is never less than 1.
//
// Input: nums = [-3,2,-3,4,2]
// Output: 5
// Explanation: If you choose startValue = 4, in the third iteration your step by step sum is less than 1.
// step by step sum
// startValue = 4 | startValue = 5 | nums
//   (4 -3 ) = 1  | (5 -3 ) = 2    |  -3
//   (1 +2 ) = 3  | (2 +2 ) = 4    |   2
//   (3 -3 ) = 0  | (4 -3 ) = 1    |  -3
//   (0 +4 ) = 4  | (1 +4 ) = 5    |   4
//   (4 +2 ) = 6  | (5 +2 ) = 7    |   2
//
// Example 2:
// Input: nums = [1,2]
// Output: 1
// Explanation: Minimum start value should be positive.
//
// Example 3:
// Input: nums = [1,-2,-3]
// Output: 5
//
// Constraints:
//     1 <= nums.length <= 100
//     -100 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  int minStartValue(List<int> nums) {
    var result = 0;
    var sum = 0;

    for (final number in nums) {
      sum += number;
      if (sum < result) result = sum;
    }

    return -result + 1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().minStartValue(nums);
}

void main(List<String> args) {
  [
    // Example 1
    SolutionTest(nums: [-3, 2, -3, 4, 2], result: 5),

    // Example 2
    SolutionTest(nums: [1, 2], result: 1),

    // Example 3
    SolutionTest(nums: [1, -2, -3], result: 5),

    // --- Edge cases ---

    // Single positive element
    SolutionTest(nums: [5], result: 1),

    // Single zero element
    SolutionTest(nums: [0], result: 1),

    // Single negative element
    SolutionTest(nums: [-5], result: 6),

    // All positives
    SolutionTest(nums: [2, 3, 4], result: 1),

    // All negatives
    SolutionTest(nums: [-1, -2, -3], result: 7),

    // Drop below 1 later in sequence
    SolutionTest(nums: [2, -5, 3], result: 4),

    // Multiple dips
    SolutionTest(nums: [-2, 3, -5, 4, -1], result: 5),

    // Zeros mixed with negatives
    SolutionTest(nums: [0, -3, 0], result: 4),

    // Large negative early
    SolutionTest(nums: [-100, 50, 60], result: 101),

    // Max length style pattern (representative)
    SolutionTest(nums: List.filled(100, -1), result: 101),

    // Alternating values
    SolutionTest(nums: [1, -1, 1, -1, 1, -1], result: 1),

    // Large positive then drop
    SolutionTest(nums: [100, -150, 30], result: 51),
  ].test();
}
