// A substring is a contiguous (non-empty) sequence of characters within a string.
// A vowel substring is a substring that only consists of vowels ('a', 'e', 'i', 'o', and 'u') and has all five vowels present in it.
// Given a string word, return the number of vowel substrings in word.
//
// Example 1:
// Input: word = "aeiouu"
// Output: 2
// Explanation: The vowel substrings of word are as follows (underlined):
// - "aeiouu"
// - "aeiouu"
//
// Example 2:
// Input: word = "unicornarihan"
// Output: 0
// Explanation: Not all 5 vowels are present, so there are no vowel substrings.
//
// Example 3:
// Input: word = "cuaieuouac"
// Output: 7
// Explanation: The vowel substrings of word are as follows (underlined):
// - "cuaieuouac"
// - "cuaieuouac"
// - "cuaieuouac"
// - "cuaieuouac"
// - "cuaieuouac"
// - "cuaieuouac"
// - "cuaieuouac"
//
// Constraints:
//     1 <= word.length <= 100
//     word consists of lowercase English letters only.

import 'testable.dart';

class Solution {
  int countVowelSubstrings(String word) {
    if (word.length < 5) return 0;

    final vowel = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0};

    bool stringIsSufficient() => !vowel.containsValue(0);

    for (var i = 0; i < 5; i++) {
      if (vowel.containsKey(word[i])) {
        vowel[word[i]] = vowel[word[i]]! + 1;
      }
    }

    var start = 0;
    var end = 4;

    while (start < word.length - vowel.length) {
      // if (!stringIsSufficient()) {
      //   if (vowel.containsKey(word[start])) {
      //     vowel[word[start]] = vowel[word[start]]! - 1;
      //   }
      //   start++;
      //
      //   if (end < word.length) {
      //     end++;
      //   }
      // }
    }
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String word;

  SolutionTest({required this.word, required super.result});

  @override
  int computeResult() => Solution().countVowelSubstrings(word);
}

void main(List<String> args) {
  [
    SolutionTest(word: "aeiouu", result: 2),
    SolutionTest(word: "unicornarihan", result: 0),
    SolutionTest(word: "cuaieuouac", result: 7),
  ].test();
}
