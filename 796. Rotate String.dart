// Given two strings s and goal, return true if and only if s can become goal after some number of shifts on s.
// A shift on s consists of moving the leftmost character of s to the rightmost position.
//
//     For example, if s = "abcde", then it will be "bcdea" after one shift.
//
// Example 1:
// Input: s = "abcde", goal = "cdeab"
// Output: true
//
// Example 2:
// Input: s = "abcde", goal = "abced"
// Output: false
//
// Constraints:
//
//     1 <= s.length, goal.length <= 100
//     s and goal consist of lowercase English letters.

import 'testable.dart';

class Solution {
  bool rotateString(String s, String goal) {
    if (s.length != goal.length) return false;

    final loop = s + s;
    return loop.contains(goal);
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s, goal;

  SolutionTest({required this.s, required this.goal, required super.result});

  @override
  bool computeResult() => Solution().rotateString(s, goal);
}

void main(List<String> args) {
  [
    SolutionTest(s: "abcde", goal: "cdeab", result: true),
    SolutionTest(s: "abcde", goal: "abced", result: false),
  ].test();
}
