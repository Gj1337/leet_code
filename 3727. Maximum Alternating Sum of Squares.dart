// You are given an integer array nums. You may rearrange the elements in any order.
// The alternating score of an array arr is defined as:
// score = arr[0]2 - arr[1]2 + arr[2]2 - arr[3]2 + ...
// Return an integer denoting the maximum possible alternating score of nums after rearranging its elements.
//
// Example 1:
// Input: nums = [1,2,3]
// Output: 12
// Explanation:
// A possible rearrangement for nums is [2,1,3], which gives the maximum alternating score among all possible rearrangements.
// The alternating score is calculated as:
// score = 22 - 12 + 32 = 4 - 1 + 9 = 12
//
// Example 2:
// Input: nums = [1,-1,2,-2,3,-3]
// Output: 16
//
// Explanation:
// A possible rearrangement for nums is [-3,-1,-2,1,3,2], which gives the maximum alternating score among all possible rearrangements.
// The alternating score is calculated as:
// score = (-3)2 - (-1)2 + (-2)2 - (1)2 + (3)2 - (2)2 = 9 - 1 + 4 - 1 + 9 - 4 = 16
//
// Constraints:
// 1 <= nums.length <= 105
// -4 * 104 <= nums[i] <= 4 * 104

import 'testable.dart';

class Solution {
  int maxAlternatingSum(List<int> nums) {
    final modNums = nums.map((number) => number * number).toList();
    modNums.sort((a, b) => b.compareTo(a));
    int sum = 0;

    for (int i = 0; i < (modNums.length + 1) ~/ 2; i++) {
      sum += modNums[i];

      final j = modNums.length - 1 - i;
      if (j > i) sum -= modNums[j];
    }
    return sum;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().maxAlternatingSum(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3], result: 12),
    SolutionTest(nums: [1, -1, 2, -2, 3, -3], result: 16),
    SolutionTest(nums: [12, -4], result: 128),
  ].test();
}
