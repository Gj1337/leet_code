// You are given an integer array nums and a positive integer k.
// A subsequent  of nums with length x is called valid if it satisfies:
//     (sub[0] + sub[1]) % k == (sub[1] + sub[2]) % k == ...
//                      ... == (sub[x - 2] + sub[x - 1]) % k.
// Return the length of the longest valid subsequence of nums.

// Example 1:
// Input: nums = [1,2,3,4,5], k = 2
// Output: 5
// Explanation:
// The longest valid subsequence is [1, 2, 3, 4, 5].

// Example 2:
// Input: nums = [1,4,2,3,1,4], k = 3
// Output: 4
// Explanation:
// The longest valid subsequence is [1, 4, 1, 4].

// Constraints:
//     2 <= nums.length <= 103
//     1 <= nums[i] <= 107
//     1 <= k <= 103

import 'testable.dart';

class Solution {
  int maximumLength(List<int> nums, int k) {
    final dp = List.generate(k, (_) => List.filled(k, 0));

    var max = 0;

    for (var num in nums) {
      for (var i = 0; i < k; i++) {
        dp[i][num % k] = dp[num % k][i] + 1;

        max = max > dp[i][num % k] ? max : dp[i][num % k];
      }
    }

    return max;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  int computeResult() => Solution().maximumLength(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 4, 5], k: 2, result: 5),
    SolutionTest(nums: [1, 4, 2, 3, 1, 4], k: 3, result: 4),
    SolutionTest(nums: [1, 2, 3, 10, 2], k: 6, result: 3),
  ].test();
}
