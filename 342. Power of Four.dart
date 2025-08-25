// Given an integer n, return true if it is a power of four.
// Otherwise, return false.
// An integer n is a power of four,
// if there exists an integer x such that n == 4x.

// Example 1:
// Input: n = 16
// Output: true

// Example 2:
// Input: n = 5
// Output: false

// Example 3:
// Input: n = 1
// Output: true

// Constraints:
//     -231 <= n <= 231 - 1

import 'testable.dart';

class Solution {
  bool isPowerOfFour(int n) =>
      n > 0 && (n & (n - 1)) == 0 && (n & 0x55555555) == n;
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  bool computeResult() => Solution().isPowerOfFour(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 2, result: false),
    SolutionTest(n: 4, result: true),
    SolutionTest(n: 8, result: false),
    SolutionTest(n: 16, result: true),
  ].test();
}
