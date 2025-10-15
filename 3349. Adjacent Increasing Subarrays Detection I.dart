// Given an array nums of n integers and an integer k, determine whether there exist two adjacent Subarray
//
// of length k such that both subarrays are strictly increasing. Specifically, check if there are two subarrays starting at indices a and b (a < b), where:
//
//     Both subarrays nums[a..a + k - 1] and nums[b..b + k - 1] are strictly increasing.
//     The subarrays must be adjacent, meaning b = a + k.
//
// Return true if it is possible to find two such subarrays, and false otherwise.
//
// Example 1:
// Input: nums = [2,5,7,8,9,2,3,4,3,1], k = 3
// Output: true
// Explanation:
//     The subarray starting at index 2 is [7, 8, 9], which is strictly increasing.
//     The subarray starting at index 5 is [2, 3, 4], which is also strictly increasing.
//     These two subarrays are adjacent, so the result is true.
//
// Example 2:
// Input: nums = [1,2,3,4,4,4,4,5,6,7], k = 5
// Output: false
//
// Constraints:
//
//     2 <= nums.length <= 100
//     1 < 2 * k <= nums.length
//     -1000 <= nums[i] <= 1000

import 'testable.dart';

class Solution {
  bool hasIncreasingSubarrays(List<int> nums, int k) {
    var current = 1, previous = 0;

    for (var i = 1; i < nums.length; i++) {
      if (nums[i - 1] < nums[i]) {
        current++;
      } else {
        previous = current;
        current = 1;
      }

      if (current >= k && previous >= k) return true;
      if (current ~/ 2 >= k) return true;
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  bool computeResult() => Solution().hasIncreasingSubarrays(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [2, 5, 7, 8, 9, 2, 3, 4, 3, 1], k: 3, result: true),
    SolutionTest(nums: [1, 2, 3, 4, 4, 4, 4, 5, 6, 7], k: 5, result: false)
  ].test();
}
