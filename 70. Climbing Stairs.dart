// You are climbing a staircase.
// It takes n steps to reach the top.
// Each time you can either climb 1 or 2 steps.
// In how many distinct ways can you climb to the top?

// Example 1:

// Input: n = 2
// Output: 2
// Explanation: There are two ways to climb to the top.
// 1. 1 step + 1 step
// 2. 2 steps

// Example 2:

// Input: n = 3
// Output: 3
// Explanation: There are three ways to climb to the top.
// 1. 1 step + 1 step + 1 step
// 2. 1 step + 2 steps
// 3. 2 steps + 1 step

// Constraints:
//     1 <= n <= 45

import 'testable.dart';

class Solution {
  int climbStairs(int n) {
    var current = 1;
    var next = 2;

    for (var i = 2; i <= n; i++) {
      final temp = current;
      current = next;
      next = next + temp;
    }

    return current;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().climbStairs(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 1, result: 1),
    SolutionTest(n: 2, result: 2),
    SolutionTest(n: 3, result: 3),
    SolutionTest(n: 4, result: 5),
    SolutionTest(n: 5, result: 8),
    SolutionTest(n: 6, result: 13),
  ].test();
}
