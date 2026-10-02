// Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
//
// Example 1:
// Input: n = 3
// Output: ["((()))","(()())","(())()","()(())","()()()"]
//
// Example 2:
// Input: n = 1
// Output: ["()"]
//
// Constraints:
// 1 <= n <= 8

import 'testable.dart';

class Solution {
  List<String> generateParenthesis(int n) {
    final result = <String>[];

    void backtrack(int opened, int closed, String currentString) {
      if (currentString.length == n * 2) {
        result.add(currentString);
        return;
      }
      if (opened < n) backtrack(opened + 1, closed, '$currentString(');
      if (opened > closed) backtrack(opened, closed + 1, '$currentString)');
    }

    backtrack(1, 0, '(');

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  List<String> computeResult() => Solution().generateParenthesis(n);
}

void main(List<String> args) {
  [
    SolutionTest(
      n: 3,
      result: ["((()))", "(()())", "(())()", "()(())", "()()()"],
    ),
    SolutionTest(n: 1, result: ["()"]),
  ].test();
}
