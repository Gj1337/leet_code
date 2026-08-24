// Given an array of positive integers arr, return the sum of all possible odd-length subarrays of arr.
//
// A subarray is a contiguous subsequence of the array.
//
// Example 1:
// Input: arr = [1,4,2,5,3]
// Output: 58
// Explanation: The odd-length subarrays of arr and their sums are:
// [1] = 1
// [4] = 4
// [2] = 2
// [5] = 5
// [3] = 3
// [1,4,2] = 7
// [4,2,5] = 11
// [2,5,3] = 10
// [1,4,2,5,3] = 15
// If we add all these together we get 1 + 4 + 2 + 5 + 3 + 7 + 11 + 10 + 15 = 58
//
// Example 2:
// Input: arr = [1,2]
// Output: 3
// Explanation: There are only 2 subarrays of odd length, [1] and [2]. Their sum is 3.
//
// Example 3:
// Input: arr = [10,11,12]
// Output: 66
//
// Constraints:
//
// 1 <= arr.length <= 100
// 1 <= arr[i] <= 1000

import 'testable.dart';

// Contribution of each element
class Solution {
  int sumOddLengthSubarrays(List<int> arr) {
    var result = 0;

    for (var i = 0; i < arr.length; i++) {
      final numberContribution = ((i + 1) * (arr.length - i) + 1) ~/ 2;
      result += arr[i] * numberContribution;
    }

    return result;
  }
}

// Prefix sum
// Time complexity = n^2 (prefixSum calculation + )
// Space complexity = n (prefixSum)
//
// class Solution {
//   int sumOddLengthSubarrays(List<int> arr) {
//     var prefixSum = [0];
//     for (var number in arr) prefixSum.add(prefixSum.last + number);
//
//     var result = 0;
//
//     print('Prefix sum $prefixSum');
//
//     for (var left = 0; left < arr.length; left++) {
//       for (var right = left; right < arr.length; right++) {
//         final lengthIsOdd = (left - right + 1).isOdd;
//
//         if (lengthIsOdd) {
//           final sumOfSubArr = prefixSum[right + 1] - prefixSum[left];
//
//           result += sumOfSubArr;
//         }
//       }
//     }
//
//     return result;
//   }
// }

// Brute force
// Time complexity = n^3 (three nested loops)
// Space complexity = 1
//
// class Solution {
//   int sumOddLengthSubarrays(List<int> arr) {
//     var result = 0;
//
//     for (var left = 0; left < arr.length; left++) {
//       for (var right = left; right < arr.length; right++) {
//         final lengthIsOdd = (left - right + 1).isOdd;
//
//         if (lengthIsOdd) {
//           final subArr = arr.sublist(left, right + 1);
//           final sumOfSubArr = subArr.reduce((a, b) => a + b);
//
//           result += sumOfSubArr;
//         }
//       }
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> arr;

  new({required this.arr, required super.result});

  @override
  int computeResult() => Solution().sumOddLengthSubarrays(arr);
}

void main(List<String> args) {
  [
    SolutionTest(arr: [1, 4, 2, 5, 3], result: 58),
    SolutionTest(arr: [1, 2], result: 3),
    SolutionTest(arr: [10, 11, 12], result: 66),
  ].test();
}
