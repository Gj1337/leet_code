// An array is considered special if every pair of its adjacent elements
// contains two numbers with different parity.

// You are given an array of integers nums. Return true
// if nums is a special array, otherwise, return false.

// Example 1:
// Input: nums = [1]
// Output: true
// Explanation:
// There is only one element. So the answer is true.

// Example 2:
// Input: nums = [2,1,4]
// Output: true
// Explanation:
// There is only two pairs: (2,1) and (1,4), and both of them contain numbers with different parity. So the answer is true.

// Example 3:
// Input: nums = [4,3,1,6]
// Output: false
// Explanation:
// nums[1] and nums[2] are both odd. So the answer is false.

// Constraints:

// 1 <= nums.length <= 100
// 1 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  bool isArraySpecial(List<int> nums) {
    for (var i = 0; i < nums.length - 1; i++) {
      if ((nums[i] % 2) == (nums[i + 1] % 2)) {
        return false;
      }
    }
    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required super.result,
  });

  final List<int> nums;

  @override
  bool computeResult() => Solution().isArraySpecial(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1], result: true),
    SolutionTest(nums: [2, 1, 4], result: true),
    SolutionTest(nums: [4, 3, 1, 6], result: false),
  ].test();
}
