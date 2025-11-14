// Given an array of integers nums, return the number of good pairs.
// A pair (i, j) is called good if nums[i] == nums[j] and i < j.
//
// Example 1:
// Input: nums = [1,2,3,1,1,3]
// Output: 4
// Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.
//
// Example 2:
// Input: nums = [1,1,1,1]
// Output: 6
// Explanation: Each pair in the array are good.
//
// Example 3:
// Input: nums = [1,2,3]
// Output: 0
//
// Constraints:
//     1 <= nums.length <= 100
//     1 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  int numIdenticalPairs(List<int> nums) {
    final freq = <int, int>{};
    for (var num in nums) {
      freq[num] = (freq[num] ?? 0) + 1;
    }

    return freq.values.fold(0, (a, b) => a + (b * (b - 1)) ~/ 2);
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().numIdenticalPairs(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 1, 1, 3], result: 4),
    SolutionTest(nums: [1, 1, 1, 1], result: 6),
    SolutionTest(nums: [1, 2, 3], result: 0),
  ].test();
}
