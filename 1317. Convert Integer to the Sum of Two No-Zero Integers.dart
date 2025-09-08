// No-Zero integer is a positive integer that does not contain any 0
// in its decimal representation.
// Given an integer n, return a list of two integers [a, b] where:
//     a and b are No-Zero integers.
//     a + b = n
// The test cases are generated so that there is at least one valid solution.
// If there are many valid solutions, you can return any of them.

// Example 1:
// Input: n = 2
// Output: [1,1]
// Explanation: Let a = 1 and b = 1.
// Both a and b are no-zero integers, and a + b = 2 = n.

// Example 2:
// Input: n = 11
// Output: [2,9]
// Explanation: Let a = 2 and b = 9.
// Both a and b are no-zero integers, and a + b = 11 = n.
// Note that there are other valid answers as [8, 3] that can be accepted.

// Constraints:
//     2 <= n <= 104

import 'testable.dart';

class Solution {
  bool isNoZeroInteger(int number) {
    if (number == 0) return false;

    var divider = 10;
    while (divider <= number) {
      final remainder = number % divider;

      if (remainder == 0) {
        return false;
      }

      number ~/= divider;
    }

    return true;
  }

  List<int> getNoZeroIntegers(int n) {
    final pair = [n - 1, 1];

    bool pairIsValid() =>
        isNoZeroInteger(pair.first) && isNoZeroInteger(pair.last);

    while (!pairIsValid()) {
      pair.first--;
      pair.last++;
    }

    return pair;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  bool isNonZeroInteger(int number) {
    final numAsString = number.toString();

    return numAsString.contains('0');
  }

  @override
  bool computeResult() {
    final result = Solution().getNoZeroIntegers(n);
    for (final num in result) {
      if (isNonZeroInteger(num)) return false;
    }
    final sum = result.reduce((sum, current) => sum + current);

    return sum == n;
  }
}

void main(List<String> args) {
  [
    SolutionTest(n: 2, result: true),
    SolutionTest(n: 5, result: true),
    SolutionTest(n: 11, result: true)
  ].test();
}
