// You are given an integer array nums.
// A subsequence sub of nums with length x
// is called valid if it satisfies:
//     (sub[0] + sub[1]) % 2 == (sub[1] + sub[2]) % 2 == ...
//                     ... == (sub[x - 2] + sub[x - 1]) % 2.
// Return the length of the longest valid subsequence of nums.
// A subsequence is an array that can be derived from
// another array by deleting some or no elements
// without changing the order of the remaining elements.

// Example 1:
// Input: nums = [1,2,3,4]
// Output: 4
// Explanation:
// The longest valid subsequence is [1, 2, 3, 4].

// Example 2:
// Input: nums = [1,2,1,1,2,1,2]
// Output: 6
// Explanation:
// The longest valid subsequence is [1, 2, 1, 2, 1, 2].

// Example 3:
// Input: nums = [1,3]
// Output: 2
// Explanation:
// The longest valid subsequence is [1, 3].

// Constraints:
//     2 <= nums.length <= 2 * 105
//     1 <= nums[i] <= 107

import 'testable.dart';

class Solution {
  int maximumLength(List<int> nums) {
    var patterns = const [
      [0, 0],
      [0, 1],
      [1, 0],
      [1, 1]
    ];

    var max = 0;

    for (var pattern in patterns) {
      var current = 0;

      for (var i = 0; i < nums.length; i++) {
        if (nums[i] % 2 == pattern[current % 2]) {
          current++;
        }
      }

      max = max < current ? current : max;
    }

    return max;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  int computeResult() => Solution().maximumLength(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 4], result: 4),
    SolutionTest(nums: [1, 2, 1, 1, 2, 1, 2], result: 6),
    SolutionTest(nums: [1, 3], result: 2),
    SolutionTest(nums: [4, 2, 6], result: 3),
    SolutionTest(nums: [1, 7, 8, 7, 5], result: 4)
  ].test();
}
