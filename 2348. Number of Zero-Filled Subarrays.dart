// Given an integer array nums, return the number of subarrays filled with 0.
// A subarray is a contiguous non-empty sequence of elements within an array.

// Example 1:
// Input: nums = [1,3,0,0,2,0,0,4]
// Output: 6
// Explanation:
// There are 4 occurrences of [0] as a subarray.
// There are 2 occurrences of [0,0] as a subarray.
// There is no occurrence of a subarray with a size more than 2 filled with 0.
// Therefore, we return 6.

// Example 2:
// Input: nums = [0,0,0,2,0,0]
// Output: 9
// Explanation:
// There are 5 occurrences of [0] as a subarray.
// There are 3 occurrences of [0,0] as a subarray.
// There is 1 occurrence of [0,0,0] as a subarray.
// There is no occurrence of a subarray with a size more than 3 filled with 0.
// Therefore, we return 9.

// Example 3:
// Input: nums = [2,10,2019]
// Output: 0
// Explanation: There is no subarray filled with 0. Therefore, we return 0.

// Constraints:
//     1 <= nums.length <= 105
//     -109 <= nums[i] <= 109

import 'testable.dart';

class Solution {
  int countSubarrays(int arraySize) => (arraySize * (arraySize + 1)) ~/ 2;

  int zeroFilledSubarray(List<int> nums) {
    var result = 0;
    var currentSubArrSize = 0;

    for (final num in nums) {
      if (num == 0) {
        currentSubArrSize++;
      } else {
        result += countSubarrays(currentSubArrSize);
        currentSubArrSize = 0;
      }
    }

    return result += countSubarrays(currentSubArrSize);
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  int computeResult() => Solution().zeroFilledSubarray(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 3, 0, 0, 2, 0, 0, 4], result: 6),
    SolutionTest(nums: [0, 0, 0, 2, 0, 0], result: 9),
    SolutionTest(nums: [2, 10, 2019], result: 0),
  ].test();
}
