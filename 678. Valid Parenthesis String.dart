// Given a string s containing only three types of characters: '(', ')' and '*', return true if s is valid.
//
// The following rules define a valid string:
//
// Any left parenthesis '(' must have a corresponding right parenthesis ')'.
// Any right parenthesis ')' must have a corresponding left parenthesis '('.
// Left parenthesis '(' must go before the corresponding right parenthesis ')'.
// '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".
//
// Example 1:
// Input: s = "()"
// Output: true
//
// Example 2:
// Input: s = "(*)"
// Output: true
//
// Example 3:
// Input: s = "(*))"
// Output: true
//
// Example 4:
// Input: s = "("
// Output: false
//
// Constraints:
// 1 <= s.length <= 100
// s[i] is '(', ')' or '*'.

import 'testable.dart';

class Solution {
  bool checkValidString(String s) {
    for (int i = 0, leftCount = 0, rightCount = 0; i < s.length; i++) {
      leftCount += s[i] == ')' ? -1 : 1;
      rightCount += s[s.length - i - 1] == '(' ? -1 : 1;
      if (rightCount < 0 || leftCount < 0) return false;
    }
    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  bool computeResult() => Solution().checkValidString(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "()", result: true),
    SolutionTest(s: "(*)", result: true),
    SolutionTest(s: "(*))", result: true),
    SolutionTest(s: "(", result: false),
  ].test();
}
