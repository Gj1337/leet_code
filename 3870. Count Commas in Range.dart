// You are given an integer n.
// Return the total number of commas used when writing all integers from [1, n] (inclusive) in standard number formatting.
// In standard formatting:
// A comma is inserted after every three digits from the right.
// Numbers with fewer than 4 digits contain no commas.
//
// Example 1:
// Input: n = 1002
// Output: 3
// Explanation:
// The numbers "1,000", "1,001", and "1,002" each contain one comma, giving a total of 3.
//
// Example 2:
// Input: n = 998
// Output: 0
//
// Explanation:
// All numbers from 1 to 998 have fewer than four digits. Therefore, no commas are used.
//
// Constraints:
// 1 <= n <= 105

import 'testable.dart';

class Solution {
  int countCommas(int n) => n > 1000 ? n - 999 : 0;
}

// class Solution {
//   int countCommas(int n) {
//     var result = 0;
//     while (n > 999) {
//       var number = n;
//       var numberOfCommas = 0;
//       while (number > 999) {
//         numberOfCommas += 1;
//         number %= 1000;
//       }
//       result += numberOfCommas;
//       n -= 1;
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().countCommas(n);
}

main() {
  [
    SolutionTest(n: 1002, result: 3),
    SolutionTest(n: 998, result: 0),
    SolutionTest(n: 1005, result: 6),
  ].test();
}
