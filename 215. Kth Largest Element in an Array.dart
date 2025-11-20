// Given an integer array nums and an integer k, return the kth largest element in the array.
// Note that it is the kth largest element in the sorted order, not the kth distinct element.
// Can you solve it without sorting?
//
// Example 1:
// Input: nums = [3,2,1,5,6,4], k = 2
// Output: 5
//
// Example 2:
// Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
// Output: 4
//
// Constraints:
//     1 <= k <= nums.length <= 105
//     -104 <= nums[i] <= 104

import 'testable.dart';

class Solution {
  int findKthLargest(List<int> nums, int k) {
    nums.sort((a, b) => b.compareTo(a));
    return nums[k - 1];
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;
  int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  int computeResult() => Solution().findKthLargest(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [3, 2, 1, 5, 6, 4], k: 2, result: 5),
    SolutionTest(nums: [3, 2, 3, 1, 2, 4, 5, 5, 6], k: 4, result: 4),
  ].test();
}
