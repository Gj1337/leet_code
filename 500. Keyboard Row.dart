// Given an array of strings words, return the words that can be typed
// using letters of the alphabet on only one row of American keyboard
// like the image below.
// Note that the strings are case-insensitive,
// both lowercased and uppercased of the same letter are treated
// as if they are at the same row.

// In the American keyboard:
//     the first row consists of the characters "qwertyuiop",
//     the second row consists of the characters "asdfghjkl", and
//     the third row consists of the characters "zxcvbnm".

// Example 1:
// Input: words = ["Hello","Alaska","Dad","Peace"]
// Output: ["Alaska","Dad"]
// Explanation:
// Both "a" and "A" are in the 2nd row of the American keyboard
// due to case insensitivity.

// Example 2:
// Input: words = ["omk"]
// Output: []

// Example 3:
// Input: words = ["adsdf","sfd"]
// Output: ["adsdf","sfd"]

import 'testable.dart';

class Solution {
  List<String> findWords(List<String> words) {
    const rows = {
      1: {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},
      2: {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'},
      3: {'z', 'x', 'c', 'v', 'b', 'n', 'm'},
    };

    final result = <String>[];

    for (final word in words) {
      if (word.isEmpty) continue;
      final lowerCaseWord = word.toLowerCase();

      final row = switch (lowerCaseWord.substring(0, 1)) {
        (final char) when rows[1]!.contains(char) => 1,
        (final char) when rows[2]!.contains(char) => 2,
        (final char) when rows[3]!.contains(char) => 3,
        _ => throw 'Unkown char'
      };

      var wordIsValid = true;
      for (var i = 0; i < lowerCaseWord.length; i++) {
        final char = lowerCaseWord[i];

        if (rows[row]!.contains(char)) continue;

        wordIsValid = false;
        break;
      }

      if (wordIsValid) result.add(word);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final List<String> words;

  SolutionTest({required this.words, required super.result});

  @override
  List<String> computeResult() => Solution().findWords(words);
}

void main(List<String> args) {
  [
    SolutionTest(
        words: ["Hello", "Alaska", "Dad", "Peace"], result: ["Alaska", "Dad"]),
    SolutionTest(words: ["omk"], result: []),
    SolutionTest(words: ["adsdf", "sfd"], result: ["adsdf", "sfd"])
  ].test();
}
