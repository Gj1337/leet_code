// Given an array of strings strs, group the Anagram together.
//   An anagram is a word or phrase formed by rearranging the letters
// of a different word or phrase, using all the original letters exactly once.
// You can return the answer in any order.

// Example 1:
// Input: strs = ["eat","tea","tan","ate","nat","bat"]
// Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
// Explanation:
//     There is no string in strs that can be rearranged to form "bat".
//     The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
//     The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.

// Example 2:
// Input: strs = [""]
// Output: [[""]]

// Example 3:
// Input: strs = ["a"]
// Output: [["a"]]

// Constraints:
//     1 <= strs.length <= 104
//     0 <= strs[i].length <= 100
//     strs[i] consists of lowercase English letters.

import 'testable.dart';

class Solution {
  List<List<String>> groupAnagrams(List<String> strs) {
    final anagrams = <String, List<String>>{};

    List<int> getCharFreq(String word) {
      final result = List.filled(26, 0); //26 - letters from "a" to "b"

      for (var i = 0; i < word.length; i++) {
        final charIndex = 122 - word[i].codeUnitAt(0);

        result[charIndex] += 1;
      }

      return result;
    }

    for (final word in strs) {
      final wordCharFreq = getCharFreq(word);
      final hashCode = wordCharFreq.join(',');

      if (!anagrams.containsKey(hashCode)) {
        anagrams[hashCode] = [];
      }

      anagrams[hashCode]!.add(word);
    }

    final wordGroups = anagrams.values.toList();

    return wordGroups;
  }
}

class SolutionTest extends Testable<List<List<String>>> with ConsoleTestOutput {
  final List<String> strs;

  SolutionTest({required this.strs, required super.result});

  @override
  List<List<String>> computeResult() => Solution().groupAnagrams(strs);

  @override
  bool validateResult(
      List<List<String>> computedResult, List<List<String>> expectedResult) {
    int sublistHash(List<String> words) => Object.hashAll(words..sort());

    final computedHashes = computedResult.map(sublistHash).toSet();
    final expectedHashes = expectedResult.map(sublistHash).toSet();

    return computedHashes.length == expectedHashes.length &&
        computedHashes.containsAll(expectedHashes);
  }
}

void main(List<String> args) {
  [
    SolutionTest(strs: [
      "eat",
      "tea",
      "tan",
      "ate",
      "nat",
      "bat"
    ], result: [
      ["bat"],
      ["nat", "tan"],
      ["ate", "eat", "tea"]
    ]),
    SolutionTest(strs: [
      ""
    ], result: [
      [""]
    ]),
    SolutionTest(strs: [
      "a"
    ], result: [
      ["a"]
    ]),
    SolutionTest(strs: [
      "abbbbbbbbbbb",
      "aaaaaaaaaaab"
    ], result: [
      ["aaaaaaaaaaab"],
      ["abbbbbbbbbbb"]
    ])
  ].test();
}
