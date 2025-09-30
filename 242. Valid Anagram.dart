// Given two strings s and t, return true if t is an
// of s, and false otherwise.

// Example 1:
// Input: s = "anagram", t = "nagaram"
// Output: true

// Example 2:
// Input: s = "rat", t = "car"
// Output: false

// Constraints:
//     1 <= s.length, t.length <= 5 * 104
//     s and t consist of lowercase English letters.

// Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?

import 'testable.dart';

class Solution {
  bool isAnagram(String s, String t) {
    if (s.length != t.length) return false;

    final counts = List<int>.filled(26, 0);

    for (var i = 0; i < s.length; i++) {
      counts[s.codeUnitAt(i) - 97]++;
      counts[t.codeUnitAt(i) - 97]--;
    }

    for (final count in counts) {
      if (count != 0) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s, t;

  SolutionTest({required this.s, required this.t, required super.result});

  @override
  bool computeResult() => Solution().isAnagram(s, t);
}

void main(List<String> args) {
  [
    SolutionTest(s: "anagram", t: "nagaram", result: true),
    SolutionTest(s: 'cat', t: 'rat', result: false),
  ].test();
}
