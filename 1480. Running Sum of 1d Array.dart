// Given an array nums.
// We define a running sum of an array as runningSum[i] = sum(nums[0]…nums[i]).
// Return the running sum of nums.

// Example 1:
// Input: nums = [1,2,3,4]
// Output: [1,3,6,10]
// Explanation: Running sum is obtained as follows: [1, 1+2, 1+2+3, 1+2+3+4].

// Example 2:
// Input: nums = [1,1,1,1,1]
// Output: [1,2,3,4,5]
// Explanation: Running sum is obtained as follows:
// [1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1].

// Example 3:
// Input: nums = [3,1,2,10,1]
// Output: [3,4,6,16,17]

// Constraints:
//     1 <= nums.length <= 1000
//     -10^6 <= nums[i] <= 10^6

import 'testable.dart';

class Solution {
  List<int> runningSum(List<int> nums) {
    var sum = 0;
    return nums.map((n) => sum += n).toList();
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  List<int> computeResult() => Solution().runningSum(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 4], result: [1, 3, 6, 10]),
    SolutionTest(nums: [1, 1, 1, 1, 1], result: [1, 2, 3, 4, 5]),
    SolutionTest(nums: [3, 1, 2, 10, 1], result: [3, 4, 6, 16, 17]),
  ].test();
}
