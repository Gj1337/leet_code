// You are given a string s consisting of lowercase English letters ('a' to 'z').
// Your task is to:
//     Find the vowel (one of 'a', 'e', 'i', 'o', or 'u') with the maximum frequency.
//     Find the consonant (all other letters excluding vowels) with the maximum frequency.

// Return the sum of the two frequencies.
// Note: If multiple vowels or consonants have the same maximum frequency, you may choose any one of them. If there are no vowels or no consonants in the string, consider their frequency as 0.
// The frequency of a letter x is the number of times it occurs in the string.

// Example 1:
// input: s = "successes"
// Output: 6
// Explanation:
//     The vowels are: 'u' (frequency 1), 'e' (frequency 2). The maximum frequency is 2.
//     The consonants are: 's' (frequency 4), 'c' (frequency 2). The maximum frequency is 4.
//     The output is 2 + 4 = 6.

// Example 2:
// Input: s = "aeiaeia"
// Output: 3
// Explanation:
//     The vowels are: 'a' (frequency 3), 'e' ( frequency 2), 'i' (frequency 2). The maximum frequency is 3.
//     There are no consonants in s. Hence, maximum consonant frequency = 0.
//     The output is 3 + 0 = 3.

// Constraints:
//     1 <= s.length <= 100
//     s consists of lowercase English letters only.

import 'testable.dart';

class Solution {
  int maxFreqSum(String s) {
    final vowel = <String, int>{'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0};

    final consonant = <String, int>{};

    for (var i = 0; i < s.length; i++) {
      if (vowel.containsKey(s[i])) {
        vowel[s[i]] = vowel[s[i]]! + 1;
      } else {
        consonant[s[i]] = (consonant[s[i]] ?? 0) + 1;
      }
    }

    final maxVowelFreq = vowel.values.fold(0, (a, b) => a > b ? a : b);
    final maxConsonantFreq = consonant.values.fold(0, (a, b) => a > b ? a : b);

    return maxVowelFreq + maxConsonantFreq;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  int computeResult() => Solution().maxFreqSum(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "successes", result: 6),
    SolutionTest(s: "aeiaeia", result: 3),
  ].test();
}
