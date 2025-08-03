// Given a string s and an integer k,
// return the maximum number of vowel letters in
// any substring of s with length k.
// Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.

// Example 1:
// Input: s = "abciiidef", k = 3
// Output: 3
// Explanation: The substring "iii" contains 3 vowel letters.

// Example 2:
// Input: s = "aeiou", k = 2
// Output: 2
// Explanation: Any substring of length 2 contains 2 vowels.

// Example 3:
// Input: s = "leetcode", k = 3
// Output: 2
// Explanation: "lee", "eet" and "ode" contain 2 vowels.

// Constraints:
//     1 <= s.length <= 105
//     s consists of lowercase English letters.
//     1 <= k <= s.length

import 'testable.dart';

const vowelChars = {'a', 'e', 'i', 'o', 'u'};

class Solution {
  int maxVowels(String s, int k) {
    var currentVowelCount = 0;

    for (var i = 0; i < k; i++) {
      if (vowelChars.contains(s[i])) currentVowelCount++;
    }
    var maxVowelCoun = currentVowelCount;

    for (var i = k; i < s.length; i++) {
      if (vowelChars.contains(s[i - k])) currentVowelCount--;
      if (vowelChars.contains(s[i])) currentVowelCount++;

      maxVowelCoun = maxVowelCoun > currentVowelCount
          ? maxVowelCoun
          : currentVowelCount;
    }

    return maxVowelCoun;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String s;
  final int k;

  SolutionTest({required this.s, required this.k, required super.result});

  @override
  int computeResult() => Solution().maxVowels(s, k);
}

void main(List<String> args) {
  [
    SolutionTest(s: "abciiidef", k: 3, result: 3),
    SolutionTest(s: "tryhard", k: 4, result: 1),
    SolutionTest(s: "aeiou", k: 2, result: 2),
  ].test();
}
