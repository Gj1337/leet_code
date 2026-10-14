// You are given two positive integers num and sum.
// A positive integer n is good if it satisfies both of the following:
// The number of digits in n is exactly num.
// The sum of digits in n is exactly sum.
// The score of a good integer n is the sum of the squares of digits in n.
// Return a string denoting the good integer n that achieves the maximum score. If there are multiple possible integers, return the maximum one. If no such integer exists, return an empty string.
//
// Example 1:
// Input: num = 2, sum = 3
// Output: "30"
// Explanation:
// There are 3 good integers: 12, 21, and 30.
// The score of 12 is 12 + 22 = 5.
// The score of 21 is 22 + 12 = 5.
// The score of 30 is 32 + 02 = 9.
// The maximum score is 9, which is achieved by the good integer 30. Therefore, the answer is "30".
//
// Example 2:
// Input: num = 2, sum = 17
// Output: "98" Explanation: There are 2 good integers: 89 and 98.
// The score of 89 is 82 + 92 = 145.
// The score of 98 is 92 + 82 = 145.
// The maximum score is 145. The maximum good integer that achieves this score is 98. Therefore, the answer is "98".
//
// Example 3:
// Input: num = 1, sum = 10
// Output: ""
// Explanation:
// There are no integers that have exactly 1 digit and whose digits sum to 10. Therefore, the answer is "".
//
// Constraints:
// 1 <= num <= 2 * 105
// 1 <= sum <= 2 * 106

import 'testable.dart';

class Solution {
  String maxSumOfSquares(int num, int sum) {
    if (num * 9 < sum) return '';

    final result = StringBuffer();
    while (sum > 0) {
      final bestNumber = switch (sum) {
        > 9 => 9,
        _ => sum,
      };
      result.write(bestNumber);
      sum -= bestNumber;
      num -= 1;
    }

    result.write('0' * num);

    return result.toString();
  }
}

// Brute force approach - works, but get TLE
//
// class Solution {
//   String maxSumOfSquares(int num, int sum) {
//     final goodIntegers = <List<int>>[];
//
//     void generateGoodInteger(List<int> currentInteger) {
//       final currentSum = currentInteger.fold(0, (a, b) => a + b);
//       final maxValue = sum - currentSum;
//       if (currentInteger.length == num) {
//         if (currentSum == sum) goodIntegers.add(currentInteger);
//
//         return;
//       }
//
//       for (var i = 0; i < 10; i++) generateGoodInteger([...currentInteger, i]);
//     }
//
//     generateGoodInteger([]);
//
//     var result = "";
//     var maximumScore = 0;
//
//     for (var list in goodIntegers) {
//       final score = list.fold(0.0, (a, b) => a * a + b * b);
//       if (score > maximumScore) result = list.fold('', (a, b) => '$a$b');
//     }
//
//     return result;
//   }
// }

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final int num;
  final int sum;

  SolutionTest({required this.num, required this.sum, required super.result});

  @override
  String computeResult() => Solution().maxSumOfSquares(num, sum);
}

void main(List<String> args) {
  [
    SolutionTest(num: 2, sum: 3, result: "30"),
    SolutionTest(num: 2, sum: 17, result: "98"),
    SolutionTest(num: 1, sum: 10, result: ""),
    SolutionTest(num: 6, sum: 4, result: "400000"),
  ].test();
}
