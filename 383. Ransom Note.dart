// Given two strings ransomNote and magazine, return true if ransomNote can be constructed by using the letters from magazine and false otherwise.
//
// Each letter in magazine can only be used once in ransomNote.
//
// Example 1:
// Input: ransomNote = "a", magazine = "b"
// Output: false
//
// Example 2:
// Input: ransomNote = "aa", magazine = "ab"
// Output: false
//
// Example 3:
// Input: ransomNote = "aa", magazine = "aab"
// Output: true
//
// Constraints:
//     1 <= ransomNote.length, magazine.length <= 105
//     ransomNote and magazine consist of lowercase English letters.

import 'testable.dart';

class Solution {
  bool canConstruct(String ransomNote, String magazine) {
    final freq = List.filled(26, 0);

    for (var i = 0; i < magazine.length; i++) {
      final codeOfChar = magazine[i].codeUnitAt(0);
      freq[codeOfChar - 97]++;
    }

    for (var i = 0; i < ransomNote.length; i++) {
      final codeOfChar = ransomNote[i].codeUnitAt(0);

      if (freq[codeOfChar - 97] == 0) return false;
      freq[codeOfChar - 97]--;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String ransomNote, magazine;

  SolutionTest({
    required this.ransomNote,
    required this.magazine,
    required super.result,
  });

  @override
  bool computeResult() => Solution().canConstruct(ransomNote, magazine);
}

void main(List<String> args) {
  [
    SolutionTest(ransomNote: "a", magazine: "b", result: false),
    SolutionTest(ransomNote: "aa", magazine: "ab", result: false),
    SolutionTest(ransomNote: "aa", magazine: "aab", result: true),
  ].test();
}
