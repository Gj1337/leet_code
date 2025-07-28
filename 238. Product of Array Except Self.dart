// Given an integer array nums,
// return an array answer such that
// answer[i] is equal to the product
//of all the elements of nums except nums[i].
// The product of any prefix or suffix of nums
// is guaranteed to fit in a 32-bit integer.
// You must write an algorithm that runs in O(n) time
// and without using the division operation.

// Example 1:
// Input: nums = [1,2,3,4]
// Output: [24,12,8,6]

// Example 2:
// Input: nums = [-1,1,0,-3,3]
// Output: [0,0,9,0,0]

// Constraints:
//     2 <= nums.length <= 105
//     -30 <= nums[i] <= 30
//     The input is generated such that
//     answer[i] is guaranteed to fit in a 32-bit integer.

// Follow up: Can you solve the problem in O(1) extra space complexity?
// (The output array does not count as extra space
// for space complexity analysis.)

import 'testable.dart';

class Solution {
  List<int> productExceptSelf(List<int> nums) {
    final result = [1];

    for (var i = 1; i < nums.length; i++) {
      result.add(result[i - 1] * nums[i - 1]);
    }

    print(result);

    var previous = 1;
    for (var i = nums.length - 1; i >= 0; i--) {
      result[i] *= previous;
      previous *= nums[i];
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  List<int> computeResult() => Solution().productExceptSelf(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 4], result: [24, 12, 8, 6]),
    SolutionTest(nums: [-1, 1, 0, -3, 3], result: [0, 0, 9, 0, 0]),
  ].test();
}
