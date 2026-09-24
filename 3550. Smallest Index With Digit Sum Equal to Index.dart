// You are given an integer array nums.
// Return the smallest index i such that the sum of the digits of nums[i] is equal to i.
// If no such index exists, return -1.
//
// Example 1:
// Input: nums = [1,3,2]
// Output: 2
// Explanation:
// For nums[2] = 2, the sum of digits is 2, which is equal to index i = 2. Thus, the output is 2.
//
// Example 2:
// Input: nums = [1,10,11]
// Output: 1
// Explanation:
// For nums[1] = 10, the sum of digits is 1 + 0 = 1, which is equal to index i = 1.
// For nums[2] = 11, the sum of digits is 1 + 1 = 2, which is equal to index i = 2.
// Since index 1 is the smallest, the output is 1.
//
// Example 3:
// Input: nums = [1,2,3]
// Output: -1
// Explanation:
// Since no index satisfies the condition, the output is -1.
//
// Constraints:
// 1 <= nums.length <= 100
// 0 <= nums[i] <= 1000

import 'testable.dart';

class Solution {
  int smallestIndex(List<int> nums) {
    for (var i = 0; i < nums.length; i++) {
      var number = nums[i];
      var sum = 0;

      while (number > 9) {
        sum += number % 10;
        number ~/= 10;
      }

      sum += number;
      if (sum == i) return i;
    }

    return -1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().smallestIndex(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 3, 2], result: 2),
    SolutionTest(nums: [1, 10, 11], result: 1),
    SolutionTest(nums: [1, 2, 3], result: -1),
  ].test();
}
