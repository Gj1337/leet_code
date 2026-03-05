// You are given a string s consisting only of the characters '0' and '1'. In one operation, you can change any '0' to '1' or vice versa.
// The string is called alternating if no two adjacent characters are equal. For example, the string "010" is alternating, while the string "0100" is not.
// Return the minimum number of operations needed to make s alternating.
//
// Example 1:
// Input: s = "0100"
// Output: 1
// Explanation: If you change the last character to '1', s will be "0101", which is alternating.
//
// Example 2:
// Input: s = "10"
// Output: 0
// Explanation: s is already alternating.
//
// Example 3:
// Input: s = "1111"
// Output: 2
// Explanation: You need two operations to reach "0101" or "1010".
//
// Constraints:
//
//     1 <= s.length <= 104
//     s[i] is either '0' or '1'.

import 'testable.dart';

class Solution {
  int minOperations(String s) {
    var chages = 0;

    for (var i = 0; i < s.length; i++) {
      final expected = i.isEven ? '0' : '1';
      if (s[i] != expected) {
        chages++;
      }
    }

    final revertChanges = s.length - chages;

    return chages < revertChanges ? chages : revertChanges;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().minOperations(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "0100", result: 1),
    SolutionTest(s: "10", result: 0),
    SolutionTest(s: "1111", result: 2),
  ].test();
}
