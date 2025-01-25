// Given an integer array arr, remove a subarray (can be empty) from arr such that the remaining elements in arr are non-decreasing.

// Return the length of the shortest subarray to remove.

// A subarray is a contiguous subsequence of the array.

// Example 1:

// Input: arr = [1,2,3,10,4,2,3,5]
// Output: 3
// Explanation: The shortest subarray we can remove is [10,4,2] of length 3. The remaining elements after that will be [1,2,3,3,5] which are sorted.
// Another correct solution is to remove the subarray [3,10,4].
// Example 2:

// Input: arr = [5,4,3,2,1]
// Output: 4
// Explanation: Since the array is strictly decreasing, we can only keep a single element. Therefore we need to remove a subarray of length 4, either [5,4,3,2] or [4,3,2,1].
// Example 3:

// Input: arr = [1,2,3]
// Output: 0
// Explanation: The array is already non-decreasing. We do not need to remove any elements.

// Constraints:

// 1 <= arr.length <= 105
// 0 <= arr[i] <= 109

import 'testable.dart';

class Solution {
  int findLengthOfShortestSubarray(List<int> arr) {
    var right = arr.length - 1 > 0 ? arr.length - 1 : 0;

    while ((right > 0) && (arr[right] >= arr[right - 1])) {
      right--;
    }

    var ans = right;

    var left = 0;
    while ((left < right) && (left == 0 || arr[left - 1] <= arr[left])) {
      while (right < arr.length && arr[left] > arr[right]) {
        right++;
      }

      ans = min(ans, right - left - 1);

      left++;
    }

    return ans;
  }
}

int min(int a, int b) => a < b ? a : b;

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.arr,
    required super.result,
  });

  final List<int> arr;

  @override
  computeResult() => Solution().findLengthOfShortestSubarray(arr);
}

void main(List<String> args) {
  [
    SolutionTest(arr: [], result: 0),
    SolutionTest(arr: [1, 2, 3, 10, 4, 2, 3, 5], result: 3),
    SolutionTest(arr: [5, 4, 3, 2, 1], result: 4),
    SolutionTest(arr: [1, 2, 3], result: 0),
    SolutionTest(arr: [1, 2, 3, 10, 0, 7, 8, 9], result: 2)
  ].test();
}
