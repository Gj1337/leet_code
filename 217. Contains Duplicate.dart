// Given an integer array nums,
// return true if any value appears at least twice in the array,
// and return false if every element is distinct.

// Example 1:
// Input: nums = [1,2,3,1]
// Output: true
// Explanation:
// The element 1 occurs at the indices 0 and 3.

// Example 2:
// Input: nums = [1,2,3,4]
// Output: false
// Explanation:
// All elements are distinct.

// Example 3:
// Input: nums = [1,1,1,3,3,4,3,2,4,2]
// Output: true

// Constraints:
//     1 <= nums.length <= 105
//     -109 <= nums[i] <= 109

import 'testable.dart';

class Solution {
  bool containsDuplicate(List<int> nums) {
    final numSet = <int>{};

    for (final number in nums) {
      if (numSet.contains(number)) return true;
      numSet.add(number);
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  bool computeResult() => Solution().containsDuplicate(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 1], result: true),
    SolutionTest(nums: [1, 2, 3, 4], result: false),
    SolutionTest(nums: [1, 1, 1, 3, 3, 4, 3, 2, 4, 2], result: true)
  ].test();
}
