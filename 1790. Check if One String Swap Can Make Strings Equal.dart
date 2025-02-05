// You are given two strings s1 and s2 of equal length.
// A string swap is an operation where you choose two indices
// in a string (not necessarily different) and
// swap the characters at these indices.

// Return true if it is possible to make both strings equal
// by performing at most one string swap on exactly one of the strings.
// Otherwise, return false.

// Example 1:
// Input: s1 = "bank", s2 = "kanb"
// Output: true
// Explanation: For example, swap the first character
// with the last character of s2 to make "bank".

// Example 2:
// Input: s1 = "attack", s2 = "defend"
// Output: false
// Explanation: It is impossible to make them equal with one string swap.

// Example 3:
// Input: s1 = "kelb", s2 = "kelb"
// Output: true
// Explanation: The two strings are already equal,
// so no string swap operation is required.

// Constraints:
// 1 <= s1.length, s2.length <= 100
// s1.length == s2.length
// s1 and s2 consist of only lowercase English letters.

import 'testable.dart';

class Solution {
  bool areAlmostEqual(String s1, String s2) {
    if (s1 == s2) return true;

    final s1Letters = s1.split('');
    final s2Letters = s2.split('');

    final wrongLetterIndexes = <int>[];

    for (var i = 0; i < s1Letters.length; i++) {
      if (s1Letters[i] != s2Letters[i]) {
        switch (wrongLetterIndexes.length) {
          case > 1:
            return false;
          case == 0:
            wrongLetterIndexes.add(i);
          case _
              when s2Letters[wrongLetterIndexes.first] == s1Letters[i] &&
                  s1Letters[wrongLetterIndexes.first] == s2Letters[i]:
            wrongLetterIndexes.add(i);
          default:
            return false;
        }
      }
    }

    return wrongLetterIndexes.length == 2;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.s1,
    required this.s2,
    required super.result,
  });

  final String s1;
  final String s2;

  @override
  bool computeResult() => Solution().areAlmostEqual(s1, s2);
}

void main(List<String> args) {
  [
    SolutionTest(s1: 'caa', s2: 'aaz', result: false),
    SolutionTest(s1: 'aa', s2: 'ac', result: false),
    SolutionTest(s1: 'bank', s2: 'kanb', result: true),
    SolutionTest(s1: 'attack', s2: 'defend', result: false),
    SolutionTest(s1: 'abcd', s2: 'dcba', result: false),
  ].test();
}
