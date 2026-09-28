// Given a valid parentheses string s, return the nesting depth of s.
// The nesting depth is the maximum number of nested parentheses.
//
// Example 1:
// Input: s = "(1+(2*3)+((8)/4))+1"
// Output: 3
// Explanation:
// Digit 8 is inside of 3 nested parentheses in the string.
//
// Example 2:
// Input: s = "(1)+((2))+(((3)))"
// Output: 3
// Explanation:
// Digit 3 is inside of 3 nested parentheses in the string.
//
// Example 3:
// Input: s = "()(())((()()))"
// Output: 3
//
// Constraints:
// 1 <= s.length <= 100
// s consists of digits 0-9 and characters '+', '-', '*', '/', '(', and ')'.
// It is guaranteed that parentheses expression s is a VPS.

import 'testable.dart';

class Solution {
  int maxDepth(String s) {
    var max = 0, current = 0;

    for (var i = 0; i < s.length; i++) {
      switch (s[i]) {
        case '(':
          current += 1;
        case ')':
          if (current > max) max = current;
          current -= 1;
      }
    }

    return max;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().maxDepth(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "(1+(2*3)+((8)/4))+1", result: 3),
    SolutionTest(s: "(1)+((2))+(((3)))", result: 3),
    SolutionTest(s: "()(())((()()))", result: 3),
  ].test();
}
