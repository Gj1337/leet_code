// Given n pairs of parentheses, write a function
// to generate all combinations of well-formed parentheses.

// Example 1:
// Input: n = 3
// Output: ["((()))","(()())","(())()","()(())","()()()"]

// Example 2:
// Input: n = 1
// Output: ["()"]

// Constraints:
// 1 <= n <= 8

import 'testable.dart';

class Solution {
  //Dynamic programming approach
  List<String> generateParenthesis(int n) {
    final result = [
      ['']
    ];

    for (var i = 1; i < n; i++) {
      final newArray = <String>[];

      for (var j = 0; j < i; j++) {
        result[j].forEach(
          (x) => result[i - j - 1].forEach(
            (y) {
              print('aDD');

              newArray.add('($x)$y');
            },
          ),
        );

        result[i].addAll(newArray);
      }

      result.forEach(print);
    }

    return result[n];
  }

  // //Recursive approach
  // List<String> generateParenthesis(int n) {
  //   final result = <String>[];

  //   void backTrack(String currentString, int left, int right) {
  //     if (currentString.length == n * 2) {
  //       result.add(currentString);
  //       return;
  //     }

  //     if (left < n) {
  //       backTrack('$currentString(', left + 1, right);
  //     }

  //     if (right < n && right < left) {
  //       backTrack('$currentString)', left, right + 1);
  //     }
  //   }

  //   backTrack('', 0, 0);

  //   return result;
  // }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  SolutionTest({
    required this.n,
    required super.result,
  });

  final int n;

  @override
  List<String> computeResult() => Solution().generateParenthesis(n);
}

void main(List<String> args) {
  Solution().generateParenthesis(1);

  [
    SolutionTest(n: 1, result: ['()']),
    SolutionTest(
      n: 3,
      result: ['((()))', '(()())', '(())()', '()(())', '()()()'],
    )
  ].test();
}
