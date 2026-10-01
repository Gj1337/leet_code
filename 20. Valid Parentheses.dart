// Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
// An input string is valid if:
// Open brackets must be closed by the same type of brackets.
// Open brackets must be closed in the correct order.
// Every close bracket has a corresponding open bracket of the same type.
//
// Example 1:
// Input: s = "()"
// Output: true
//
// Example 2:
// Input: s = "()[]{}"
// Output: true
//
// Example 3:
// Input: s = "(]"
// Output: false
//
// Example 4:
// Input: s = "([])"
// Output: true
//
// Example 5:
// Input: s = "([)]"
// Output: false
//
// Constraints:
// 1 <= s.length <= 104
// s consists of parentheses only '()[]{}'.

import 'testable.dart';

class Solution {
  bool isValid(String s) {
    final stack = <String>[];
    const match = {'(': ')', '[': ']', '{': '}'};

    for (var i = 0; i < s.length; i++) {
      if (match.containsKey(s[i])) {
        stack.add(s[i]);
      } else {
        if (stack.isEmpty || match[stack.removeLast()] != s[i]) return false;
      }
    }

    return stack.isEmpty;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  bool computeResult() => Solution().isValid(s);
}

main() {
  [
    SolutionTest(s: "()", result: true),
    SolutionTest(s: "()[]{}", result: true),
    SolutionTest(s: "(]", result: false),
    SolutionTest(s: "([])", result: true),
    SolutionTest(s: "([)]", result: false),
  ].test();
}
