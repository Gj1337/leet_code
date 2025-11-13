// Given a 0-indexed string word and a character ch, reverse the segment of word that starts at index 0 and ends at the index of the first occurrence of ch (inclusive). If the character ch does not exist in word, do nothing.
//
// For example, if word = "abcdefd" and ch = "d", then you should reverse the segment that starts at 0 and ends at 3 (inclusive). The resulting string will be "dcbaefd".
// Return the resulting string.
//
// Example 1:
// Input: word = "abcdefd", ch = "d"
// Output: "dcbaefd"
// Explanation: The first occurrence of "d" is at index 3.
// Reverse the part of word from 0 to 3 (inclusive), the resulting string is "dcbaefd".
//
// Example 2:
// Input: word = "xyxzxe", ch = "z"
// Output: "zxyxxe"
// Explanation: The first and only occurrence of "z" is at index 3.
// Reverse the part of word from 0 to 3 (inclusive), the resulting string is "zxyxxe".
//
// Example 3:
// Input: word = "abcd", ch = "z"
// Output: "abcd"
// Explanation: "z" does not exist in word.
// You should not do any reverse operation, the resulting string is "abcd".
//
// Constraints:
// 1 <= word.length <= 250
// word consists of lowercase English letters.
// ch is a lowercase English letter.

import 'testable.dart';

class Solution {
  String reversePrefix(String word, String ch) {
    final stack = <String>[];
    final chars = word.split('');
    var stepper = 0;

    print(chars);
    for (var i = 0; i < chars.length; i++) {
      stack.add(chars[i]);
      if (chars[i] == ch[stepper]) {
        if (stepper + 1 == ch.length) {
          final stackLength = stack.length;
          for (var j = 0; j < stackLength; j++) {
            chars[j] = stack.removeLast();
          }
          return chars.join();
        }
        stepper++;
      } else {
        stepper = 0;
      }
    }

    return word;
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String word, ch;

  SolutionTest({
    required this.word,
    required this.ch,
    required super.result,
  });

  @override
  String computeResult() => Solution().reversePrefix(word, ch);
}

void main(List<String> args) {
  [
    SolutionTest(word: "abcdefd", ch: "d", result: "dcbaefd"),
    SolutionTest(word: "xyxzxe", ch: "z", result: "zxyxxe"),
    SolutionTest(word: "abcd", ch: "z", result: "abcd"),
  ].test();
}
