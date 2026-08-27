// You are given an integer array nums and two integers l and r. Your task is to find the minimum sum of a subarray whose size is between l and r (inclusive) and whose sum is greater than 0.
//
// Return the minimum sum of such a subarray. If no such subarray exists, return -1.
// A subarray is a contiguous non-empty sequence of elements within an array.
//
// Example 1:
// Input: nums = [3, -2, 1, 4], l = 2, r = 3
// Output: 1
// Explanation:
// The subarrays of length between l = 2 and r = 3 where the sum is greater than 0 are:
// [3, -2] with a sum of 1
// [1, 4] with a sum of 5
// [3, -2, 1] with a sum of 2
// [-2, 1, 4] with a sum of 3
// Out of these, the subarray [3, -2] has a sum of 1, which is the smallest positive sum. Hence, the answer is 1.
//
// Example 2:
// Input: nums = [-2, 2, -3, 1], l = 2, r = 3
// Output: -1
// Explanation:
// There is no subarray of length between l and r that has a sum greater than 0. So, the answer is -1.
//
// Example 3:
// Input: nums = [1, 2, 3, 4], l = 2, r = 4
// Output: 3
// Explanation:
// The subarray [1, 2] has a length of 2 and the minimum sum greater than 0. So, the answer is 3.
//
// Constraints:
//
// 1 <= nums.length <= 100
// 1 <= l <= r <= nums.length
// -1000 <= nums[i] <= 1000

import 'testable.dart';

class Solution {
  int minimumSumSubarray(List<int> nums, int l, int r) {
    var result = -1;

    for (var left = 0; left < nums.length; left++) {
      var currentSum = 0;

      for (
        var right = left, subArrayLenght = right - left + 1;
        subArrayLenght <= r && right < nums.length;
        right++, subArrayLenght = right - left + 1
      ) {
        currentSum += nums[right];

        if ((l <= subArrayLenght && subArrayLenght <= r) &&
            (currentSum > 0) &&
            (result == -1 || currentSum < result)) {
          result = currentSum;
        }
      }
    }

    return result;
  }
}

// Prefix sum
// Time complexity = n^2
// class Solution {
//   int minimumSumSubarray(List<int> nums, int l, int r) {
//     final prefixSum = [0];
//     for (final number in nums) prefixSum.add(prefixSum.last + number);
//
//     var result = -1;
//
//     for (var left = 0; left < nums.length; left++) {
//       for (var right = left; right < nums.length; right++) {
//         final sublistLength = right - left + 1;
//         final sublistIsSufficient = l <= sublistLength && sublistLength <= r;
//
//         if (sublistIsSufficient) {
//           final subilistElementsSum = prefixSum[right + 1] - prefixSum[left];
//
//           if (subilistElementsSum > 0 &&
//               ((result == -1) || (subilistElementsSum < result))) {
//             result = subilistElementsSum;
//           }
//         }
//       }
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int l;
  final int r;

  SolutionTest({
    required this.nums,
    required this.l,
    required this.r,
    required super.result,
  });

  @override
  int computeResult() => Solution().minimumSumSubarray(nums, l, r);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [3, -2, 1, 4], l: 2, r: 3, result: 1),
    SolutionTest(nums: [-2, 2, -3, 1], l: 2, r: 3, result: -1),
    SolutionTest(nums: [1, 2, 3, 4], l: 2, r: 4, result: 3),
  ].test();
}
