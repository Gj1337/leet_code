// A parentheses string is valid if and only if:
//
// It is the empty string,
// It can be written as AB (A concatenated with B), where A and B are valid strings, or
// It can be written as (A), where A is a valid string.
// You are given a parentheses string s. In one move, you can insert a parenthesis at any position of the string.
//
// For example, if s = "()))", you can insert an opening parenthesis to be "(()))" or a closing parenthesis to be "())))".
// Return the minimum number of moves required to make s valid.
//
// Example 1:
// Input: s = "())"
// Output: 1
//
// Example 2:
// Input: s = "((("
// Output: 3
//
// Constraints:
// 1 <= s.length <= 1000
// s[i] is either '(' or ')'.

import 'testable.dart';

class Solution {
  int minAddToMakeValid(String s) {
    final stack = <String>[];

    for (var i = 0; i < s.length; i++) {
      switch (s[i]) {
        case '(':
          stack.add(s[i]);
        case ')':
          stack.isNotEmpty && stack.last == '('
              ? stack.removeLast()
              : stack.add(s[i]);
      }
    }

    return stack.length;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().minAddToMakeValid(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "())", result: 1),
    SolutionTest(s: "(((", result: 3),
    SolutionTest(s: "()))((", result: 4),
  ].test();
}
