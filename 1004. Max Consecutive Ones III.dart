// Given a binary array nums and an integer k,
// return the maximum number of consecutive 1's in the array
// if you can flip at most k 0's.

// Example 1:
// Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
// Output: 6
// Explanation: [1,1,1,0,0,1,1,1,1,1,1]
// Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.

// Example 2:
// Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
// Output: 10
// Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
// Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.

// Constraints
//     1 <= nums.length <= 105
//     nums[i] is either 0 or 1.
//     0 <= k <= nums.length

import 'testable.dart';

class Solution {
  int longestSubarray(List<int> nums) {
    var leftPointer = 0;
    var rightPointer = 0;
    var maxLength = 0;

    var zeroCount = 0;

    while (rightPointer < nums.length) {
      if (nums[rightPointer] == 0) {
        zeroCount++;
      }
      rightPointer++;

      while (zeroCount > 1) {
        if (nums[leftPointer] == 0) {
          zeroCount--;
        }
        leftPointer++;
      }

      final currentLenght = rightPointer - leftPointer;
      maxLength = maxLength > currentLenght ? maxLength : currentLenght;
    }

    return maxLength - 1;
  }

  int longestOnes(List<int> nums, int k) {
    var leftPointer = 0;
    var rightPointer = 0;
    var maxLength = 0;

    var zeroCount = 0;

    while (rightPointer < nums.length) {
      if (nums[rightPointer] == 0) {
        zeroCount++;
      }
      rightPointer++;

      while (zeroCount > k) {
        if (nums[leftPointer] == 0) {
          zeroCount--;
        }
        leftPointer++;
      }

      final currentLenght = rightPointer - leftPointer;
      maxLength = maxLength > currentLenght ? maxLength : currentLenght;
    }

    return maxLength;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required this.k,
    required super.result,
  });

  final List<int> nums;
  final int k;

  @override
  int computeResult() => Solution().longestOnes(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0], k: 2, result: 6)
  ].test();
}
