// Given an array of integers temperatures represents the daily temperatures,
// return an array answer such that answer[i] is the number of days you have to wait
// after the ith day to get a warmer temperature.
// If there is no future day for which this is possible, keep answer[i] == 0 instead.
//
// Example 1:
// Input: temperatures = [73,74,75,71,69,72,76,73]
// Output: [1,1,4,2,1,1,0,0]
//
// Example 2:
// Input: temperatures = [30,40,50,60]
// Output: [1,1,1,0]
//
// Example 3:
// Input: temperatures = [30,60,90]
// Output: [1,1,0]
//
// Constraints:
// 1 <= temperatures.length <= 105
// 30 <= temperatures[i] <= 100

import 'testable.dart';

class Solution {
  List<int> dailyTemperatures(List<int> temperatures) {
    final stack = <int>[];
    final result = List.filled(temperatures.length, 0);

    for (var i = 0; i < temperatures.length; i++) {
      while (stack.isNotEmpty && temperatures[stack.last] < temperatures[i]) {
        result[stack.last] = i - stack.removeLast();
      }
      stack.add(i);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> temperatures;

  SolutionTest({required this.temperatures, required super.result});

  @override
  List<int> computeResult() => Solution().dailyTemperatures(temperatures);
}

void main(List<String> args) {
  [
    SolutionTest(
      temperatures: [73, 74, 75, 71, 69, 72, 76, 73],
      result: [1, 1, 4, 2, 1, 1, 0, 0],
    ),
    SolutionTest(temperatures: [30, 40, 50, 60], result: [1, 1, 1, 0]),
    SolutionTest(temperatures: [30, 60, 90], result: [1, 1, 0]),
  ].test();
}
