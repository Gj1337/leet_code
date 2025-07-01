// Alice is attempting to type a specific string on her computer.
// However, she tends to be clumsy and may press a key for too long,
// resulting in a character being typed multiple times.
// Although Alice tried to focus on her typing,
// she is aware that she may still have done this at most once.

// You are given a string word,
// which represents the final output displayed on Alice's screen.

// Return the total number of possible original strings that
// Alice might have intended to type.

// Example 1:
// Input: word = "abbcccc"
// Output: 5
// Explanation:
// The possible strings are: "abbcccc", "abbccc", "abbcc",
// "abbc", and "abcccc".

// Example 2:
// Input: word = "abcd"
// Output: 1
// Explanation:
// The only possible string is "abcd".

// Example 3:
// Input: word = "aaaa"
// Output:

// Constraints:
// 1 <= word.length <= 100
// word consists only of lowercase English letters.

import 'testable.dart';

class Solution {
  int possibleStringCount(String word) {
    var count = 1;

    final chars = word.split('');

    for (var i = 1; i < chars.length; i++) {
      if (chars[i] == chars[i - 1]) {
        count++;
      }
    }

    return count;
  }
}

class SolutionTest<int> extends Testable with ConsoleTestOutput {
  SolutionTest({
    required this.word,
    required super.result,
  });

  final String word;

  @override
  computeResult() => Solution().possibleStringCount(word);
}

void main(List<String> args) {
  [
    SolutionTest(word: "abbcccc", result: 5),
    SolutionTest(word: "aaaa", result: 4),
    SolutionTest(word: "abcd", result: 1),
  ].test();
}
