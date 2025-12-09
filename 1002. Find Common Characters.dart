// Given a string array words, return an array of all characters that show up in all strings within the words (including duplicates). You may return the answer in any order.
//
// Example 1:
// Input: words = ["bella","label","roller"]
// Output: ["e","l","l"]
//
// Example 2:
// Input: words = ["cool","lock","cook"]
// Output: ["c","o"]
//
// Constraints:
// 1 <= words.length <= 100
// 1 <= words[i].length <= 100
// words[i] consists of lowercase English letters.

import 'testable.dart';

class Solution {
  List<String> commonChars(List<String> words) {
    final freq = <String, int>{};
    final wordFreq = <String, int>{};

    for (var i = 0; i < words.first.length; i++) {
      freq[words.first[i]] = (freq[words.first[i]] ?? 0) + 1;
    }

    for (var i = 1; i < words.length; i++) {
      wordFreq.clear();
      for (var j = 0; j < words[i].length; j++) {
        wordFreq[words[i][j]] = (wordFreq[words[i][j]] ?? 0) + 1;
      }

      for (final char in freq.keys.toList()) {
        final wordChar = wordFreq[char];

        if (wordChar == null) {
          freq.remove(char);
        } else {
          freq[char] =
              (freq[char]! > wordFreq[char]!) ? wordFreq[char]! : freq[char]!;
        }
      }
    }

    final result = <String>[];
    for (final entire in freq.entries) {
      result.addAll(List.generate(entire.value, (_) => entire.key));
    }

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final List<String> words;

  SolutionTest({required this.words, required super.result});

  @override
  List<String> computeResult() => Solution().commonChars(words);
}

void main(List<String> args) {
  [
    SolutionTest(words: ["bella", "label", "roller"], result: ["e", "l", "l"]),
    SolutionTest(words: ["cool", "lock", "cook"], result: ["c", "o"]),
  ].test();
}
