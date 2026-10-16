// The Tribonacci sequence Tn is defined as follows:
// T0 = 0, T1 = 1, T2 = 1, and Tn+3 = Tn + Tn+1 + Tn+2 for n >= 0.
// Given n, return the value of Tn.
//
// Example 1:
// Input: n = 4
// Output: 4
// Explanation:
// T_3 = 0 + 1 + 1 = 2
// T_4 = 1 + 1 + 2 = 4
//
// Example 2:
// Input: n = 25
// Output: 1389537
//
// Constraints:
// 0 <= n <= 37
// The answer is guaranteed to fit within a 32-bit integer, ie. answer <= 2^31 - 1.

import 'testable.dart';

class Solution {
  int tribonacci(int n) => [
    0,
    1,
    1,
    2,
    4,
    7,
    13,
    24,
    44,
    81,
    149,
    274,
    504,
    927,
    1705,
    3136,
    5768,
    10609,
    19513,
    35890,
    66012,
    121415,
    223317,
    410744,
    755476,
    1389537,
    2555757,
    4700770,
    8646064,
    15902591,
    29249425,
    53798080,
    98950096,
    181997601,
    334745777,
    615693474,
    1132436852,
    2082876103,
  ][n];
}

// class Solution {
//   int tribonacci(int n) {
//     if (n == 0) return 0;
//     if (n <= 2) return 1;
//     final aa = [0, 1, 1];
//
//     var a = 0, b = 1, c = 1;
//
//     for (var i = 3; i <= n; i++) {
//       final next = a + b + c;
//       aa.add(next);
//       a = b;
//       b = c;
//       c = next;
//     }
//
//     print(aa);
//     return c;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().tribonacci(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 4, result: 4),
    SolutionTest(n: 25, result: 1389537),
    SolutionTest(n: 37, result: 2082876103),
  ].test();
}
