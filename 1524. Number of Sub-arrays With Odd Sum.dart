// Given an array of integers arr, return the number of subarrays with an odd sum.
// Since the answer can be very large, return it modulo 109 + 7.
//
// Example 1:
// Input: arr = [1,3,5]
// Output: 4
// Explanation: All subarrays are [[1],[1,3],[1,3,5],[3],[3,5],[5]]
// All sub-arrays sum are [1,4,9,3,8,5].
// Odd sums are [1,9,3,5] so the answer is 4.
//
// Example 2:
// Input: arr = [2,4,6]
// Output: 0
// Explanation: All subarrays are [[2],[2,4],[2,4,6],[4],[4,6],[6]]
// All sub-arrays sum are [2,6,12,4,10,6].
// All sub-arrays have even sum and the answer is 0.
//
// Example 3:
// Input: arr = [1,2,3,4,5,6,7]
// Output: 16
//
// Constraints:
// 1 <= arr.length <= 105
// 1 <= arr[i] <= 100

import 'testable.dart';

class Solution {
  int numOfSubarrays(List<int> arr) {
    int result = 0, oddCount = 0, eventCount = 1, prefixSum = 0;

    for (int number in arr) {
      prefixSum += number;

      if (prefixSum.isOdd) {
        result += eventCount;
        oddCount += 1;
      } else {
        result += oddCount;
        eventCount += 1;
      }
    }

    return result % 10_000_000_007;
  }
}

// TLE
// class Solution {
//   int numOfSubarrays(List<int> arr) {
//     if (arr.isEmpty) return 0;
//     int result = 0;
//     bool? prefixSumIsOdd;
//
//     for (var i = 0; i < arr.length; i++) {
//       prefixSumIsOdd = null;
//       for (var j = i; j < arr.length; j++) {
//         if (arr[j].isEven && prefixSumIsOdd == null ||
//             arr[j].isOdd && prefixSumIsOdd == true ||
//             arr[j].isEven && prefixSumIsOdd == false) {
//           prefixSumIsOdd = false;
//         } else if (arr[j].isOdd && prefixSumIsOdd == null ||
//             arr[j].isOdd && prefixSumIsOdd == false ||
//             arr[j].isEven && prefixSumIsOdd == true) {
//           result += 1;
//           prefixSumIsOdd = true;
//         }
//       }
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> arr;

  SolutionTest({required this.arr, required super.result});

  @override
  int computeResult() => Solution().numOfSubarrays(arr);
}

void main(List<String> args) {
  [
    SolutionTest(arr: [1, 3, 5], result: 4),
    SolutionTest(arr: [2, 4, 6], result: 0),
    SolutionTest(arr: [1, 2, 3, 4, 5, 6, 7], result: 16),
  ].test();
}
