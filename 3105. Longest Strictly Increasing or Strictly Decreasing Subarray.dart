// You are given an array of integers nums. Return the length of the longest
// subarray
//  of nums which is either
// strictly increasing
//  or
// strictly decreasing
// .

// Example 1:
// Input: nums = [1,4,3,3,2]
// Output: 2
// Explanation:
// The strictly increasing subarrays of nums are [1], [2], [3], [3], [4], and [1,4].
// The strictly decreasing subarrays of nums are [1], [2], [3], [3], [4], [3,2], and [4,3].
// Hence, we return 2.

// Example 2:
// Input: nums = [3,3,3,3]
// Output: 1
// Explanation:
// The strictly increasing subarrays of nums are [3], [3], [3], and [3].
// The strictly decreasing subarrays of nums are [3], [3], [3], and [3].
// Hence, we return 1.

// Example 3:
// Input: nums = [3,2,1]
// Output: 3
// Explanation:
// The strictly increasing subarrays of nums are [3], [2], and [1].
// The strictly decreasing subarrays of nums are [3], [2], [1], [3,2], [2,1], and [3,2,1].
// Hence, we return 3.

// Constraints:

// 1 <= nums.length <= 50
// 1 <= nums[i] <= 50

import 'testable.dart';

class Solution {
  int longestMonotonicSubarray(List<int> nums) {
    if (nums.isEmpty) return 0;

    var maxIncreasingLenght = 1;
    var maxDecreasingLenght = 1;

    var currentMaxIncreasingLenght = 1;
    var currentMaxDecreasingLenght = 1;

    for (var i = 0; i < nums.length - 1; i++) {
      if (nums[i] < nums[i + 1]) {
        currentMaxIncreasingLenght++;
        maxIncreasingLenght =
            _max(maxIncreasingLenght, currentMaxIncreasingLenght);
      } else {
        currentMaxIncreasingLenght = 1;
      }

      if (nums[i] > nums[i + 1]) {
        currentMaxDecreasingLenght++;
        maxDecreasingLenght =
            _max(maxDecreasingLenght, currentMaxDecreasingLenght);
      } else {
        currentMaxDecreasingLenght = 1;
      }
    }

    return _max(maxIncreasingLenght, maxDecreasingLenght);
  }

  int _max(int a, int b) => a > b ? a : b;
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required super.result,
  });

  final List<int> nums;

  @override
  int computeResult() => Solution().longestMonotonicSubarray(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1], result: 1),
    SolutionTest(nums: [], result: 0),
    SolutionTest(nums: [1, 4, 3, 3, 2], result: 2),
    SolutionTest(nums: [3, 3, 3, 3], result: 1),
    SolutionTest(nums: [3, 2, 1], result: 3)
  ].test();
}
