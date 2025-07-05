// Given an array of integers arr, a lucky integer is
// an integer that has a frequency in the array equal to its value.
// Return the largest lucky integer in the array.
// If there is no lucky integer return -1.

// Example 1:
// Input: arr = [2,2,3,4]
// Output: 2
// Explanation: The only lucky number in the array is 2
// because frequency[2] == 2.

// Example 2:
// Input: arr = [1,2,2,3,3,3]
// Output: 3
// Explanation: 1, 2 and 3 are all lucky numbers,
// return the largest of them.

// Example 3:
// Input: arr = [2,2,2,3,3]
// Output: -1
// Explanation: There are no lucky numbers in the array.

// Constraints:
//     1 <= arr.length <= 500
//     1 <= arr[i] <= 500

import 'testable.dart';

class Solution {
  int findLucky(List<int> arr) {
    final freq = <int, int>{};

    for (var i = 0; i < arr.length; i++) {
      freq[arr[i]] = freq[arr[i]] != null ? freq[arr[i]]! + 1 : 1;
    }

    freq.removeWhere((key, value) => key != value);

    return freq.keys.fold(
      -1,
      (previous, current) => previous > current ? previous : current,
    );
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.arr, required super.result});

  final List<int> arr;

  @override
  int computeResult() => Solution().findLucky(arr);
}

void main(List<String> args) {
  [
    SolutionTest(arr: [2, 2, 3, 4], result: 2),
    SolutionTest(arr: [1, 2, 2, 3, 3, 3], result: 3),
    SolutionTest(arr: [2, 2, 2, 3, 3], result: -1),
    SolutionTest(arr: [4, 3, 2, 2, 4, 1, 3, 4, 3], result: 3),
  ].test();
}
