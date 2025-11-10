// Given two strings s and t, return true if they are equal when both are typed into empty text editors. '#' means a backspace character.
//
// Note that after backspacing an empty text, the text will continue empty.
//
// Example 1:
// Input: s = "ab#c", t = "ad#c"
// Output: true
// Explanation: Both s and t become "ac".
//
// Example 2:
// Input: s = "ab##", t = "c#d#"
// Output: true
// Explanation: Both s and t become "".
//
// Example 3:
// Input: s = "a#c", t = "b"
// Output: false
// Explanation: s becomes "c" while t becomes "b".
//
// Constraints:
// 1 <= s.length, t.length <= 200
// s and t only contain lowercase letters and '#' characters.
//
// Follow up: Can you solve it in O(n) time and O(1) space?

import 'testable.dart';

class Solution {
  bool backspaceCompare(String s, String t) {
    String processString(String s) {
      final stack = <String>[];

      for (var i = 0; i < s.length; i++) {
        if (s[i] == '#') {
          if (stack.isNotEmpty) stack.removeLast();
        } else {
          stack.add(s[i]);
        }
      }

      return stack.join();
    }

    return processString(s) == processString(t);
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s, t;

  SolutionTest({
    required this.s,
    required this.t,
    required super.result,
  });

  @override
  bool computeResult() => Solution().backspaceCompare(s, t);
}

void main(List<String> args) {
  [
    SolutionTest(s: "ab#c", t: "ad#c", result: true),
    SolutionTest(s: "ab##", t: "c#d#", result: true),
    SolutionTest(s: "a#c", t: "b", result: false),
  ].test();
}
