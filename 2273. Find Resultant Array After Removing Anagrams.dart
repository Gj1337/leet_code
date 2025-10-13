// You are given a 0-indexed string array words, where words[i] consists of lowercase English letters.
//
// In one operation, select any index i such that 0 < i < words.length and words[i - 1] and words[i] are anagrams, and delete words[i] from words. Keep performing this operation as long as you can select an index that satisfies the conditions.
//
// Return words after performing all operations. It can be shown that selecting the indices for each operation in any arbitrary order will lead to the same result.
//
// An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase using all the original letters exactly once. For example, "dacb" is an anagram of "abdc".
//
// Example 1:
// Input: words = ["abba","baba","bbaa","cd","cd"]
// Output: ["abba","cd"]
// Explanation:
// One of the ways we can obtain the resultant array is by using the following operations:
// - Since words[2] = "bbaa" and words[1] = "baba" are anagrams, we choose index 2 and delete words[2].
//   Now words = ["abba","baba","cd","cd"].
// - Since words[1] = "baba" and words[0] = "abba" are anagrams, we choose index 1 and delete words[1].
//   Now words = ["abba","cd","cd"].
// - Since words[2] = "cd" and words[1] = "cd" are anagrams, we choose index 2 and delete words[2].
//   Now words = ["abba","cd"].
// We can no longer perform any operations, so ["abba","cd"] is the final answer.
//
// Example 2:
// Input: words = ["a","b","c","d","e"]
// Output: ["a","b","c","d","e"]
// Explanation:
// No two adjacent strings in words are anagrams of each other, so no operations are performed.
//
// Constraints:
//
//     1 <= words.length <= 100
//     1 <= words[i].length <= 10
//     words[i] consists of lowercase English letters.

import 'testable.dart';

class Solution {
  List<String> removeAnagrams(List<String> words) {
    var currentAnagram = <int>[];
    final result = <String>[];

    for (var i = 0; i < words.length; i++) {
      final wordFreq = List.filled(26, 0);

      for (var j = 0; j < words[i].length; j++) {
        final charCode = words[i][j].codeUnitAt(0) - 97;
        wordFreq[charCode]++;
      }

      if (!listsAreEqual(currentAnagram, wordFreq)) {
        result.add(words[i]);
        currentAnagram = wordFreq;
      }
    }

    return result;
  }

  bool listsAreEqual(List<int> a, List<int> b) {
    if (a.length != b.length) return false;

    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final List<String> words;

  SolutionTest({required this.words, required super.result});

  @override
  List<String> computeResult() => Solution().removeAnagrams(words);

  @override
  bool validateResult(
      List<String> computedResult, List<String> expectedResult) {
    if (computedResult.length != expectedResult.length) return false;

    computedResult.sort();
    expectedResult.sort();

    for (var i = 0; i < computedResult.length; i++) {
      if (computedResult[i] != expectedResult[i]) {
        return false;
      }
    }

    return true;
  }
}

void main(List<String> args) {
  [
    SolutionTest(
        words: ["abba", "baba", "bbaa", "cd", "cd"], result: ["abba", "cd"]),
    SolutionTest(
        words: ["a", "b", "c", "d", "e"], result: ["a", "b", "c", "d", "e"]),
  ].test();
}
