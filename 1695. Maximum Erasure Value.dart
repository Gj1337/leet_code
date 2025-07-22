// You are given an array of positive integers nums
// and want to erase a subarray containing unique elements.
// The score you get by erasing the subarray
// is equal to the sum of its elements.
// Return the maximum score you can get by erasing exactly one subarray.
// An array b is called to be a subarray of a
//if it forms a contiguous subsequence of a,
// that is, if it is equal to a[l],a[l+1],...,a[r] for some (l,r).

// Example 1:
// Input: nums = [4,2,4,5,6]
// Output: 17
// Explanation: The optimal subarray here is [2,4,5,6].

// Example 2:
// Input: nums = [5,2,1,2,5,2,1,2,5]
// Output: 8
// Explanation: The optimal subarray here is [5,2,1] or [1,2,5].

// Constraints:
//     1 <= nums.length <= 105
//     1 <= nums[i] <= 104

import 'testable.dart';

class Solution {
  int maximumUniqueSubarray(List<int> nums) {
    var maxSum = 0;
    var currentSum = 0;
    final memorySet = <int>{};

    var firstPointer = 0;
    var secondPointer = 0;

    while (secondPointer < nums.length) {
      while (memorySet.contains(nums[secondPointer])) {
        currentSum -= nums[firstPointer];
        memorySet.remove(nums[firstPointer]);
        firstPointer++;
      }

      memorySet.add(nums[secondPointer]);
      currentSum += nums[secondPointer];

      maxSum = currentSum > maxSum ? currentSum : maxSum;
      secondPointer++;
    }
    maxSum = currentSum > maxSum ? currentSum : maxSum;

    return maxSum;
  }
}

class SolutionTest extends Testable with ConsoleTestOutput {
  SolutionTest({required this.nums, required super.result});

  final List<int> nums;

  @override
  computeResult() => Solution().maximumUniqueSubarray(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [4, 2, 4, 5, 6], result: 17),
    SolutionTest(nums: [5, 2, 1, 2, 5, 2, 1, 2, 5], result: 8),
  ].test();
}
