// Given a positive integer, check whether it has alternating bits:
// namely, if two adjacent bits will always have different values.

// Example 1:
// Input: n = 5
// Output: true
// Explanation: The binary representation of 5 is: 101

// Example 2:
// Input: n = 7
// Output: false
// Explanation: The binary representation of 7 is: 111.

// Example 3:
// Input: n = 11
// Output: false
// Explanation: The binary representation of 11 is: 1011.

// Constraints:
// 1 <= n <= 231 - 1

import 'testable.dart';

class Solution {
  bool hasAlternatingBits(int n) {
    var previousBit = n % 2;
    n >>= 1;

    while (n > 0) {
      final currentBit = n % 2;

      if (currentBit == previousBit) return false;

      previousBit = currentBit;

      n >>= 1;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.n,
    required super.result,
  });

  final int n;

  @override
  bool computeResult() => Solution().hasAlternatingBits(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 5, result: true),
    SolutionTest(n: 10, result: true),
    SolutionTest(n: 11, result: false),
    SolutionTest(n: 7, result: false),
  ].test();
}
