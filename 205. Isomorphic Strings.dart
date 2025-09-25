// Given two strings s and t, determine if they are isomorphic.
// Two strings s and t are isomorphic if the characters
// in s can be replaced to get t.
// All occurrences of a character must be replaced with another character
// while preserving the order of characters.
// No two characters may map to the same character,
// but a character may map to itself.

// Example 1:
// Input: s = "egg", t = "add"
// Output: true
// Explanation:
// The strings s and t can be made identical by:
//     Mapping 'e' to 'a'.
//     Mapping 'g' to 'd'.

// Example 2:
// Input: s = "foo", t = "bar"
// Output: false
// Explanation:
// The strings s and t can not be made identical
// as 'o' needs to be mapped to both 'a' and 'r'.

// Example 3:
// Input: s = "paper", t = "title"
// Output: true

// Constraints:
//     1 <= s.length <= 5 * 104
//     t.length == s.length
//     s and t consist of any valid ascii character.

import 'testable.dart';

class Solution {
  bool isIsomorphic(String s, String t) {
    if (s.length != t.length) return false;

    final mapS = <String, String>{};
    final mapT = <String, String>{};

    for (var i = 0; i < s.length; i++) {
      if ((mapS[s[i]] ?? t[i]) != t[i] || (mapT[t[i]] ?? s[i]) != s[i]) {
        return false;
      }

      mapS[s[i]] = t[i];
      mapT[t[i]] = s[i];
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s;
  final String t;

  SolutionTest({required this.s, required this.t, required super.result});

  @override
  bool computeResult() => Solution().isIsomorphic(s, t);
}

void main(List<String> args) {
  [
    SolutionTest(s: 'egg', t: 'add', result: true),
    SolutionTest(s: 'foo', t: 'bar', result: false),
    SolutionTest(s: 'paper', t: 'title', result: true),
    SolutionTest(s: 'babc', t: 'baba', result: false)
  ].test();
}
