// A fancy string is a string where no three
// consecutive characters are equal.
// Given a string s, delete the minimum possible number
// of characters from s to make it fancy.
// Return the final string after the deletion.
// It can be shown that the answer will always be unique.

// Example 1:
// Input: s = "leeetcode"
// Output: "leetcode"
// Explanation:
// Remove an 'e' from the first group of 'e's to create "leetcode".
// No three consecutive characters are equal, so return "leetcode".

// Example 2:
// Input: s = "aaabaaaa"
// Output: "aabaa"
// Explanation:
// Remove an 'a' from the first group of 'a's to create "aabaaaa".
// Remove two 'a's from the second group of 'a's to create "aabaa".
// No three consecutive characters are equal, so return "aabaa".

// Example 3:
// Input: s = "aab"
// Output: "aab"
// Explanation: No three consecutive characters are equal, so return "aab".

// Constraints:
//     1 <= s.length <= 105
//     s consists only of lowercase English letters.

import 'testable.dart';

class Solution {
  String makeFancyString(String s) {
    final chars = s.split('');

    if (chars.length < 3) return s;

    final result = StringBuffer('');

    for (var i = 0; i < s.length - 2; i++) {
      final threeInRowCondition =
          chars[i] == chars[i + 1] && chars[i] == chars[i + 2];

      if (threeInRowCondition) continue;

      result.write(chars[i]);
    }

    result.writeAll([chars[chars.length - 2], chars[chars.length - 1]]);

    return result.toString();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({required this.s, required super.result});

  final String s;

  @override
  String computeResult() => Solution().makeFancyString(s);
}

void main(List<String> args) {
  [SolutionTest(s: 'leeetcode', result: 'leetcode')].test();
}
