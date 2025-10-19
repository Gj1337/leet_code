// Given two strings s and goal, return true if you can swap two letters in s so the result is equal to goal, otherwise, return false.
//
// Swapping letters is defined as taking two indices i and j (0-indexed) such that i != j and swapping the characters at s[i] and s[j].
//
//     For example, swapping at indices 0 and 2 in "abcd" results in "cbad".
//
// Example 1:
// Input: s = "ab", goal = "ba"
// Output: true
// Explanation: You can swap s[0] = 'a' and s[1] = 'b' to get "ba", which is equal to goal.
//
// Example 2:
// Input: s = "ab", goal = "ab"
// Output: false
// Explanation: The only letters you can swap are s[0] = 'a' and s[1] = 'b', which results in "ba" != goal.
//
// Example 3:
// Input: s = "aa", goal = "aa"
// Output: true
// Explanation: You can swap s[0] = 'a' and s[1] = 'a' to get "aa", which is equal to goal.
//
// Constraints:
//
//     1 <= s.length, goal.length <= 2 * 104
//     s and goal consist of lowercase letters.

import 'testable.dart';

class Solution {
  bool buddyStrings(String s, String goal) {
    if (s.length != goal.length) return false;

    if (s == goal) {
      final set = <String>{};
      for (var i = 0; i < s.length; i++) {
        if (set.contains(s[i])) return true;

        set.add(s[i]);
      }
    }

    final diff = <String>[];
    for (var i = 0; i < s.length; i++) {
      if (s[i] != goal[i]) diff.addAll([s[i], goal[i]]);
      if (diff.length > 4) return false;
    }

    if (diff.length == 4 && diff[0] == diff[3] && diff[1] == diff[2]) {
      return true;
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s, goal;

  SolutionTest({required this.s, required this.goal, required super.result});

  @override
  bool computeResult() => Solution().buddyStrings(s, goal);
}

void main(List<String> args) {
  [
    SolutionTest(s: "ab", goal: "ba", result: true),
    SolutionTest(s: "ab", goal: "ab", result: false),
    SolutionTest(s: "aa", goal: "aa", result: true),
  ].test();
}
