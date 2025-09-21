// Given an array nums of size n, return the majority element.
// The majority element is the element that appears more than ⌊n / 2⌋ times.
// You may assume that the majority element always exists in the array.

// Example 1:
// Input: nums = [3,2,3]
// Output: 3

// Example 2:
// Input: nums = [2,2,1,1,1,2,2]
// Output: 2

// Constraints:
//     n == nums.length
//     1 <= n <= 5 * 104
//     -109 <= nums[i] <= 109

import 'testable.dart';

class Solution {
  int majorityElement(List<int> nums) {
    var majorNum = 0, majorNumFreq = 0;

    for (final num in nums) {
      if (majorNumFreq == 0) majorNum = num;
      num == majorNum ? majorNumFreq++ : majorNumFreq--;
    }

    return majorNum;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().majorityElement(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [3, 2, 3], result: 3),
    SolutionTest(nums: [2, 2, 1, 1, 1, 2, 2], result: 2)
  ].test();
}
