// Given two strings s and t, return true if s is a subsequence of t, or false otherwise.

// A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

// Example 1:

// Input: s = "abc", t = "ahbgdc"
// Output: true
// Example 2:

// Input: s = "axc", t = "ahbgdc"
// Output: false

// Constraints:

// 0 <= s.length <= 100
// 0 <= t.length <= 104
// s and t consist only of lowercase English letters.

// Follow up: Suppose there are lots of incoming s, say s1, s2, ..., sk where k >= 109, and you want to check one by one to see if t has its subsequence. In this scenario, how would you change your code?

import 'testable.dart';

class Solution {
  bool isSubsequence(String s, String t) {
    if (s.isEmpty) return true;
    if (s.length > t.length) return false;

    final sChars = s.split('');
    final tChars = t.split('');

    var fPointer = 0;

    for (final char in tChars) {
      if (char == sChars[fPointer]) {
        fPointer++;

        if (fPointer == sChars.length) return true;
      }
    }

    return fPointer == sChars.length;
  }
}

final class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest(this.s, this.t, {required super.result});

  final String s;
  final String t;

  @override
  bool computeResult() => Solution().isSubsequence(s, t);
}

void main(List<String> args) {
  [
    SolutionTest("abc", "ahbgdc", result: true),
    SolutionTest("axc", "ahbgdc", result: false),
    SolutionTest("", "ahbgdc", result: true),
    SolutionTest("ahbgdc", "ahbgdc", result: true),
    SolutionTest("b", "abc", result: true),
    SolutionTest("b", "ac", result: false),
    SolutionTest("abc", "", result: false),
    SolutionTest("aa", "aab", result: true),
    SolutionTest("aaa", "aa", result: false),
    SolutionTest("ace", "abcde", result: true),
    SolutionTest("aec", "abcde", result: false),
    SolutionTest("verylong", "thisisalongstringthatcontainsverylonginside",
        result: true),
    SolutionTest("notpresent", "thisisalongstring", result: false),
    SolutionTest("aaaaaa", "baabaaaab", result: true)
  ].test();
}
