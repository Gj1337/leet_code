// A square triple (a,b,c) is a triple where a, b, and c are integers and a2 + b2 = c2.
// Given an integer n, return the number of square triples such that 1 <= a, b, c <= n.
//
// Example 1:
// Input: n = 5
// Output: 2
// Explanation: The square triples are (3,4,5) and (4,3,5).
//
// Example 2:
// Input: n = 10
// Output: 4
// Explanation: The square triples are (3,4,5), (4,3,5), (6,8,10), and (8,6,10).
//
// Constraints:
// 1 <= n <= 250

import 'testable.dart';
import 'dart:math';

class Solution {
  int countTriples(int n) {
    int count = 0;

    for (int a = 1; a <= n; a++) {
      for (int b = 1; b <= n; b++) {
        final cSquared = a * a + b * b;
        final cDouble = sqrt(cSquared);
        final c = cDouble.toInt();

        if (c > n) continue;
        if (c * c == cSquared) count++;
      }
    }

    return count;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().countTriples(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 5, result: 2),
    SolutionTest(n: 10, result: 4),
  ].test();
}
