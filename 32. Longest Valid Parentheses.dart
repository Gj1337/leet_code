// Given a string containing just the characters '(' and ')',
// return the length of the longest valid (well-formed) parentheses substring.
//
// Example 1:
// Input: s = "(()"
// Output: 2
// Explanation: The longest valid parentheses substring is "()".
//
// Example 2:
// Input: s = ")()())"
// Output: 4
// Explanation: The longest valid parentheses substring is "()()".
//
// Example 3:
// Input: s = ""
// Output: 0
//
// Constraints:
// 0 <= s.length <= 3 * 104
// s[i] is '(', or ')'.

import 'testable.dart';

class Solution {
  int longestValidParentheses(String s) {
    final stack = [-1];
    var maxLenght = 0;

    for (var i = 0; i < s.length; i++) {
      if (s[i] == '(') {
        stack.add(i);
      } else if (s[i] == ')') {
        stack.removeLast();
        if (stack.isEmpty) {
          stack.add(i);
        } else {
          final lenght = i - stack.last;
          if (maxLenght < lenght) maxLenght = lenght;
        }
      }
    }

    return maxLenght;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().longestValidParentheses(s);
}

main() {
  [
    SolutionTest(s: "(()", result: 2),
    SolutionTest(s: ")()())", result: 4),
    SolutionTest(s: "", result: 0),
  ].test();
}
