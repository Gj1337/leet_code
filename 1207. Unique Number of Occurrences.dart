// Given an array of integers arr, return true
// if the number of occurrences of each value in the array is unique
// or false otherwise.

// Example 1:
// Input: arr = [1,2,2,1,1,3]
// Output: true
// Explanation: The value 1 has 3 occurrences,
// 2 has 2 and 3 has 1. No two values have the same number of occurrences.

// Example 2:
// Input: arr = [1,2]
// Output: false

// Example 3:
// Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
// Output: true

// Constraints:
//     1 <= arr.length <= 1000
//     -1000 <= arr[i] <= 1000

import 'testable.dart';

class Solution {
  bool uniqueOccurrences(List<int> arr) {
    final freqMap = <int, int>{};
    arr.forEach((num) => freqMap[num] = (freqMap[num] ?? 0) + 1);
    final set = <int>{};
    for (final freq in freqMap.values) {
      if (!set.add(freq)) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.arr,
    required super.result,
  });

  final List<int> arr;

  @override
  bool computeResult() => Solution().uniqueOccurrences(arr);
}

void main(List<String> args) {
  [
    SolutionTest(arr: [1, 2, 2, 1, 1, 3], result: true),
    SolutionTest(arr: [1, 2], result: false),
    SolutionTest(arr: [-3, 0, 1, -3, 1, 1, 1, -3, 10, 0], result: true)
  ].test();
}
