// Given a string s, sort it in decreasing order based on the frequency of the characters. The frequency of a character is the number of times it appears in the string.
// Return the sorted string. If there are multiple answers, return any of them.

// Example 1:
// Input: s = "tree"
// Output: "eert"
// Explanation: 'e' appears twice while 'r' and 't' both appear once.
// So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.

// Example 2:
// Input: s = "cccaaa"
// Output: "aaaccc"
// Explanation: Both 'c' and 'a' appear three times, so both "cccaaa" and "aaaccc" are valid answers.
// Note that "cacaca" is incorrect, as the same characters must be together.

// Example 3:
// Input: s = "Aabb"
// Output: "bbAa"
// Explanation: "bbaA" is also a valid answer, but "Aabb" is incorrect.
// Note that 'A' and 'a' are treated as two different characters.

// Constraints:
//     1 <= s.length <= 5 * 105
//     s consists of uppercase and lowercase English letters and digits.

import 'testable.dart';

class Solution {
  String frequencySort(String s) {
    final freq = List.filled(122 - 48 + 1, 0);

    for (var i = 0; i < s.length; i++) {
      freq[s[i].codeUnitAt(0) - 48]++;
    }
    final stringBuffer = StringBuffer();

    while (true) {
      var maxFreq = 0;
      var maxFreqIndex = -1;
      for (var i = 0; i < freq.length; i++) {
        if (freq[i] > maxFreq) {
          maxFreq = freq[i];
          maxFreqIndex = i;
        }
      }

      if (maxFreqIndex != -1) {
        stringBuffer.write((String.fromCharCode(maxFreqIndex + 48)) * maxFreq);
        freq[maxFreqIndex] = 0;
      } else
        break;
    }

    return stringBuffer.toString();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  String computeResult() => Solution().frequencySort(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "tree", result: "eert"),
    SolutionTest(s: "cccaaa", result: "aaaccc"),
    SolutionTest(s: "Aabb", result: "bbAa")
  ].test();
}
