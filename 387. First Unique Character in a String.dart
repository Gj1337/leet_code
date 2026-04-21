// Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

// Example 1:
// Input: s = "leetcode"
// Output: 0

// Explanation:
// The character 'l' at index 0 is the first character that does not occur at any other index.

// Example 2:
// Input: s = "loveleetcode"
// Output: 2

// Example 3:
// Input: s = "aabb"
// Output: -1

// Constraints:
// 1 <= s.length <= 105
// s consists of only lowercase English letters.

import 'testable.dart';

class Solution {
  int firstUniqChar(String s) {
    final freqAlphabet = List.filled(26, 0);

    for (var i = 0; i < s.length; i++) {
      final char = s[i];
      final charCode = char.codeUnitAt(0) - 97;

      freqAlphabet[charCode] = freqAlphabet[charCode] + 1;
    }

    for (var i = 0; i < s.length; i++) {
      final char = s[i];
      final charCode = char.codeUnitAt(0) - 97;

      if (freqAlphabet[charCode] == 1) return i;
    }

    return -1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().firstUniqChar(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: 'leetcode', result: 0),
    SolutionTest(s: "loveleetcode", result: 2),
    SolutionTest(s: "aabb", result: -1),
  ].test();
}
