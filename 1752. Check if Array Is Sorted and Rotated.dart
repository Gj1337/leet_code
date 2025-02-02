// Given an array nums, return true
// if the array was originally sorted in non-decreasing order,
// then rotated some number of positions (including zero).
// Otherwise, return false.
// There may be duplicates in the original array.
// Note: An array A rotated by x positions results
// in an array B of the same length such that
// A[i] == B[(i+x) % A.length], where % is the modulo operation.

// Example 1:
// Input: nums = [3,4,5,1,2]
// Output: true
// Explanation: [1,2,3,4,5] is the original sorted array.
// You can rotate the array by x = 3 positions
// to begin on the the element of value 3: [3,4,5,1,2].

// Example 2:
// Input: nums = [2,1,3,4]
// Output: false
// Explanation: There is no sorted array once rotated
// that can make nums.

// Example 3:
// Input: nums = [1,2,3]
// Output: true
// Explanation: [1,2,3] is the original sorted array.
// You can rotate the array by x = 0 positions (i.e. no rotation)
// to make nums.

// Constraints:
// 1 <= nums.length <= 100
// 1 <= nums[i] <= 100

import 'testable.dart';

class Solution {
  bool check(List<int> nums) {
    var n = nums.length;
    var count = 0;

    for (int i = 0; i < n; i++) {
      if (nums[i] > nums[(i + 1) % n]) {
        count++;
      }
    }

    return count <= 1;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required super.result,
  });

  final List<int> nums;

  @override
  bool computeResult() => Solution().check(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [5, 1, 2, 3, 4], result: true),
    SolutionTest(nums: [3, 4, 5, 1, 2], result: true),
    SolutionTest(nums: [2, 1, 3, 4], result: false),
    SolutionTest(nums: [1, 2, 3], result: true),
    SolutionTest(nums: [1], result: true),
    SolutionTest(nums: [1, 1, 1], result: true),
    SolutionTest(nums: [1, 2, 1], result: true),
    SolutionTest(nums: [1, 2, 3, 1], result: true),
    SolutionTest(nums: [1, 2, 3, 4, 1], result: true),
    SolutionTest(nums: [4, 5, 1, 2, 3], result: true),
    SolutionTest(nums: [1, 2, 1, 2], result: false),
    SolutionTest(nums: [2, 1, 2, 1], result: false),
    SolutionTest(nums: [1, 2, 3, 4, 2], result: false),
    SolutionTest(nums: [1, 2, 3, 4, 5, 1], result: true),
    SolutionTest(nums: [1, 1, 2, 2, 3, 1], result: true),
    SolutionTest(nums: [2, 1, 2, 2, 3], result: false),
    SolutionTest(nums: [1, 2, 2, 1], result: true),
    SolutionTest(nums: [2, 2, 1, 2], result: true),
    SolutionTest(nums: [1, 2, 3, 1, 2], result: false),
    SolutionTest(nums: [1, 1, 1, 1, 1], result: true),
    SolutionTest(nums: [1, 1, 1, 2, 1], result: true),
    SolutionTest(nums: [1, 2, 1, 1, 1], result: true),
    SolutionTest(nums: [2, 1, 1, 1, 1], result: true),
    SolutionTest(nums: [1, 1, 2, 1, 1], result: true),
    SolutionTest(nums: [1, 1, 1, 1, 2], result: true),
    SolutionTest(nums: [2, 1, 1, 1, 2], result: true),
    SolutionTest(nums: [1, 2, 1, 1, 2], result: false),
  ].test();
}
