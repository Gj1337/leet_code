// Two strings are considered close if you can attain one
// from the other using the following operations:
//     Operation 1: Swap any two existing characters.
//         For example, abcde -> aecdb
//     Operation 2: Transform every occurrence of one existing character into
//         another existing character,
//         and do the same with the other character.
//         For example, aacabb -> bbcbaa
//          (all a's turn into b's, and all b's turn into a's)
// You can use the operations on either string as many times as necessary.
// Given two strings, word1 and word2, return true
// if word1 and word2 are close, and false otherwise.

// Example 1:
// Input: word1 = "abc", word2 = "bca"
// Output: true
// Explanation: You can attain word2 from word1 in 2 operations.
// Apply Operation 1: "abc" -> "acb"
// Apply Operation 1: "acb" -> "bca"

// Example 2:
// Input: word1 = "a", word2 = "aa"
// Output: false
// Explanation: It is impossible to attain word2 from word1,
// or vice versa, in any number of operations.

// Example 3:
// Input: word1 = "cabbba", word2 = "abbccc"
// Output: true
// Explanation: You can attain word2 from word1 in 3 operations.
// Apply Operation 1: "cabbba" -> "caabbb"
// Apply Operation 2: "caabbb" -> "baaccc"
// Apply Operation 2: "baaccc" -> "abbccc"

// Constraints:
//     1 <= word1.length, word2.length <= 105
//     word1 and word2 contain only lowercase English letters.

import 'testable.dart';

class Solution {
  bool closeStrings(String word1, String word2) {
    if (word1.length != word2.length) return false;

    final word1FreqMap = {
      'a': 0, 'b': 0, 'c': 0, 'd': 0, 'e': 0, 'f': 0, 'g': 0, 
      'h': 0, 'i': 0, 'j': 0, 'k': 0, 'l': 0, 'm': 0, 'n': 0, 
      'o': 0, 'p': 0, 'q': 0, 'r': 0, 's': 0, 't': 0, 'u': 0, 
      'v': 0, 'w': 0, 'x': 0, 'y': 0, 'z': 0,
      };

    final word2FreqMap = Map.of(word1FreqMap);
    
    word1
        .split('')
        .forEach((char) => word1FreqMap[char] = (word1FreqMap[char] ?? 0) + 1);
    word2
        .split('')
        .forEach((char) => word2FreqMap[char] = (word2FreqMap[char] ?? 0) + 1);

    for (final key in word1FreqMap.keys) {
      final char1Exist = (word1FreqMap[key] ?? 0) > 0;
      final char2Exist = (word2FreqMap[key] ?? 0) > 0;

      if (char1Exist != char2Exist) return false;
    }

    final word1CharFreq = word1FreqMap.values.toList()..sort();
    final word2CharFreq = word2FreqMap.values.toList()..sort();

    for (var i = 0; i < word1CharFreq.length; i++) {
      if (word1CharFreq[i] != word2CharFreq[i]) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.word1,
    required this.word2,
    required super.result,
  });

  final String word1;
  final String word2;

  @override
  bool computeResult() => Solution().closeStrings(word1, word2);
}

void main(List<String> args) {
  [
    SolutionTest(word1: "abc", word2: "bca", result: true),
    SolutionTest(word1: "a", word2: "aa", result: false),
    SolutionTest(word1: "cabbba", word2: "abbccc", result: true),
    SolutionTest(word1: "uau", word2: "ssx", result: false),
    SolutionTest(word1: "mkmczky", word2: "cckcmmy", result: false),
  ].test();
}
