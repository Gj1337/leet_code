// Hercy wants to save money for his first car. He puts money in the Leetcode bank every day.
//
// He starts by putting in $1 on Monday, the first day. Every day from Tuesday to Sunday, he will put in $1 more than the day before. On every subsequent Monday, he will put in $1 more than the previous Monday.
//
// Given n, return the total amount of money he will have in the Leetcode bank at the end of the nth day.
//
// Example 1:
// Input: n = 4
// Output: 10
// Explanation: After the 4th day, the total is 1 + 2 + 3 + 4 = 10.
//
// Example 2:
// Input: n = 10
// Output: 37
// Explanation: After the 10th day, the total is (1 + 2 + 3 + 4 + 5 + 6 + 7) + (2 + 3 + 4) = 37. Notice that on the 2nd Monday, Hercy only puts in $2.
//
// Example 3:
// Input: n = 20
// Output: 96
// Explanation: After the 20th day, the total is (1 + 2 + 3 + 4 + 5 + 6 + 7) + (2 + 3 + 4 + 5 + 6 + 7 + 8) + (3 + 4 + 5 + 6 + 7 + 8) = 96.
//
// Constraints:
// 1 <= n <= 1000

import 'testable.dart';

class Solution {
  int totalMoney(int n) {
    final fullWeeks = n ~/ 7;
    final remainingDays = n % 7;

    final savingsFullWeeks = (fullWeeks * (7 * fullWeeks + 49)) ~/ 2;

    final savingsRemainingDays =
        (remainingDays * (2 * fullWeeks + remainingDays + 1)) ~/ 2;

    return savingsFullWeeks + savingsRemainingDays;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().totalMoney(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 4, result: 10),
    SolutionTest(n: 10, result: 37),
    SolutionTest(n: 20, result: 96)
  ].test();
}
