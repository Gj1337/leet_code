// You are given a string s that consists of lower case English letters and brackets.
// Reverse the strings in each pair of matching parentheses, starting from the innermost one.
// Your result should not contain any brackets.
//
// Example 1:
// Input: s = "(abcd)"
// Output: "dcba"
//
// Example 2:
// Input: s = "(u(love)i)"
// Output: "iloveu"
// Explanation: The substring "love" is reversed first, then the whole string is reversed.
//
// Example 3:
// Input: s = "(ed(et(oc))el)"
// Output: "leetcode"
// Explanation: First, we reverse the substring "oc", then "etco", and finally, the whole string.
//
// Constraints:
// 1 <= s.length <= 2000
// s only contains lower case English characters and parentheses.
// It is guaranteed that all parentheses are balanced.

import 'testable.dart';

class Solution {
  String reverseParentheses(String s) {
    final stack = <int>[];
    var result = <String>[];

    for (var i = 0, j = 0; i < s.length; i++) {
      switch (s[i]) {
        case '(':
          stack.add(j);
        case ')':
          final startReverseIndex = stack.removeLast();

          result.replaceRange(
            startReverseIndex,
            j,
            result.getRange(startReverseIndex, j).toList().reversed.toList(),
          );

        default:
          j++;
          result.add(s[i]);
      }
    }

    return result.join();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  String computeResult() => Solution().reverseParentheses(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "(abcd)", result: "dcba"),
    SolutionTest(s: "(u(love)i)", result: "iloveu"),
    SolutionTest(s: "(ed(et(oc))el)", result: "leetcode"),
  ].test();
}
