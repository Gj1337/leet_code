// Given a balanced parentheses string s, return the score of the string.
//
// The score of a balanced parentheses string is based on the following rule:
//
// "()" has score 1.
// AB has score A + B, where A and B are balanced parentheses strings.
// (A) has score 2 * A, where A is a balanced parentheses string.
//
// Example 1:
// Input: s = "()"
// Output: 1
//
// Example 2:
// Input: s = "(())"
// Output: 2
//
// Example 3:
// Input: s = "()()"
// Output: 2
//
// Constraints:
// 2 <= s.length <= 50
// s consists of only '(' and ')'.
// s is a balanced parentheses string.

import 'testable.dart';

class Solution {
  int scoreOfParentheses(String s) {
    final stack = <int>[0];

    for (final char in s.split('')) {
      if (char == '(') {
        stack.add(0);
      } else {
        final inner = stack.removeLast();
        final score = inner == 0 ? 1 : 2 * inner;
        stack.last += score;
      }
      print(stack);
    }

    return stack.last;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().scoreOfParentheses(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "()", result: 1),
    SolutionTest(s: "(())", result: 2),
    SolutionTest(s: "()()", result: 2),
    SolutionTest(s: "(()(()))", result: 6),
  ].test();
}
