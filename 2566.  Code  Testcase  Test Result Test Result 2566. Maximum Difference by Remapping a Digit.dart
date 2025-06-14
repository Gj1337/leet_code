// You are given an integer num. You know that Bob will sneakily remap one
// of the 10 possible digits (0 to 9) to another digit.

// Return the difference between the maximum and minimum values
// Bob can make by remapping exactly one digit in num.

// Notes:

// When Bob remaps a digit d1 to another digit d2,
// Bob replaces all occurrences of d1 in num with d2.
// Bob can remap a digit to itself, in which case num does not change.
// Bob can remap different digits for obtaining minimum and
// maximum values respectively.
// The resulting number after remapping can contain leading zeroes.

// Example 1:

// Input: num = 11891
// Output: 99009
// Explanation:
// To achieve the maximum value, Bob can remap
// the digit 1 to the digit 9 to yield 99899.
// To achieve the minimum value, Bob can remap
// the digit 1 to the digit 0, yielding 890.
// The difference between these two numbers is 99009.
// Example 2:

// Input: num = 90
// Output: 99
// Explanation:
// The maximum value that can be returned by the function
// is 99 (if 0 is replaced by 9) and the minimum value that can
// be returned by the function is 0 (if 9 is replaced by 0).
// Thus, we return 99.

// Constraints:

// 1 <= num <= 108

import 'testable.dart';

class Solution {
  int minMaxDifference(int num) {
    final digits = getDigits(num);

    int? replacementForMax;
    int? replacementForMin;

    int max = 0;
    int min = 0;

    for (var i = 0; i < digits.length; i++) {
      int currentMax = digits[i];
      int currentMin = digits[i];

      switch (digits[i]) {
        case < 9 when replacementForMax == null:
          replacementForMax = digits[i];
          currentMax = 9;

        case _ when digits[i] == replacementForMax:
          currentMax = 9;
      }
      max = max * 10 + currentMax;

      switch (digits[i]) {
        case > 0 when replacementForMin == null:
          replacementForMin = digits[i];
          currentMin = 0;

        case _ when digits[i] == replacementForMin:
          currentMin = 0;
      }
      min = min * 10 + currentMin;
    }

    return max - min;
  }

  List<int> getDigits(int num) {
    if (num == 0) return [0];

    var _num = num;
    final result = <int>[];

    while (_num != 0) {
      final digit = _num % 10;

      result.add(digit);
      _num ~/= 10;
    }

    return result.reversed.toList();
  }
}

final class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.num,
    required super.result,
  });

  final int num;

  @override
  computeResult() => Solution().minMaxDifference(num);
}

void main(List<String> args) {
  [
    SolutionTest(num: 0, result: 9),
    SolutionTest(num: 9999, result: 9999),
    SolutionTest(num: 90, result: 99),
    SolutionTest(num: 11891, result: 99009),
  ].test();
}
