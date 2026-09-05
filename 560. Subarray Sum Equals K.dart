// Given an array of integers nums and an integer k, return the total number of subarrays whose sum equals to k.
// A subarray is a contiguous non-empty sequence of elements within an array.
//
// Example 1:
// Input: nums = [1,1,1], k = 2
// Output: 2
//
// Example 2:
// Input: nums = [1,2,3], k = 3
// Output: 2
//
// Constraints:
// 1 <= nums.length <= 2 * 104
// -1000 <= nums[i] <= 1000
// -107 <= k <= 107

import 'testable.dart';

//Time complexity O(n)

class Solution {
  int subarraySum(List<int> nums, int k) {
    var sum = 0, result = 0;
    final sums = {0: 1};

    for (var number in nums) {
      sum += number;

      result += sums[sum - k] ?? 0;
      sums[sum] = (sums[sum] ?? 0) + 1;
    }

    return result;
  }
}

// Time complexity O(n^2)
//
// class Solution {
//   int subarraySum(List<int> nums, int k) {
//     final prefixSum = [0];
//     for (var number in nums) prefixSum.add(prefixSum.last + number);
//
//     var result = 0;
//     for (var i = 0; i < nums.length; i++) {
//       for (var j = i; j < nums.length; j++) {
//         final sum = prefixSum[j + 1] - prefixSum[i];
//         if (sum == k) result += 1;
//       }
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  int computeResult() => Solution().subarraySum(nums, k);
}

main() {
  [
    SolutionTest(nums: [1, 1, 1], k: 2, result: 2),
    SolutionTest(nums: [1, 2, 3], k: 3, result: 2),
  ].test();
}
