// An integer x is numerically balanced if for every digit d in the number x, there are exactly d occurrences of that digit in x.
//
// Given an integer n, return the smallest numerically balanced number strictly greater than n.
//
// Example 1:
// Input: n = 1
// Output: 22
// Explanation:
// 22 is numerically balanced since:
// - The digit 2 occurs 2 times.
// It is also the smallest numerically balanced number strictly greater than 1.
//
// Example 2:
// Input: n = 1000
// Output: 1333
// Explanation:
// 1333 is numerically balanced since:
// - The digit 1 occurs 1 time.
// - The digit 3 occurs 3 times.
// It is also the smallest numerically balanced number strictly greater than 1000.
// Note that 1022 cannot be the answer because 0 appeared more than 0 times.
//
// Example 3:
// Input: n = 3000
// Output: 3133
// Explanation:
// 3133 is numerically balanced since:
// - The digit 1 occurs 1 time.
// - The digit 3 occurs 3 times.
// It is also the smallest numerically balanced number strictly greater than 3000.
//
// Constraints:
//     0 <= n <= 106

import 'testable.dart';

class Solution {
  bool numberIsBeautiful(int n) {
    var number = n.abs();
    final freq = <int, int>{0: 0};

    while (number > 0) {
      final digit = number % 10;

      freq[digit] = (freq[digit] ?? 0) + 1;

      number ~/= 10;
    }

    for (var key in freq.keys) {
      if (freq[key] != key) return false;
    }

    return true;
  }

  int nextBeautifulNumber(int n) {
    do {
      n++;
    } while (!numberIsBeautiful(n));

    return n;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().nextBeautifulNumber(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 1, result: 22),
    SolutionTest(n: 1000, result: 1333),
    SolutionTest(n: 3000, result: 3133),
  ].test();
}
