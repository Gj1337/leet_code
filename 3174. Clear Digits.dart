// You are given a string s.
// Your task is to remove all digits by doing this operation repeatedly:
// Delete the first digit and the closest non-digit character to its left.
// Return the resulting string after removing all digits.

// Example 1:
// Input: s = "abc"
// Output: "abc"
// Explanation:
// There is no digit in the string.

// Example 2:
// Input: s = "cb34"
// Output: ""
// Explanation:
// First, we apply the operation on s[2], and s becomes "c4".
// Then we apply the operation on s[1], and s becomes "".

// Constraints:
// 1 <= s.length <= 100
// s consists only of lowercase English letters and digits.
// The input is generated such that it is possible to delete all digits.

import 'testable.dart';

const _digits = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};

class Solution {
  String clearDigits(String s) {
    final letters = s.split('');
    final resultLetters = <String>[];

    for (var i = 0; i < letters.length; i++) {
      if (_digits.contains(letters[i]) && resultLetters.isNotEmpty) {
        resultLetters.removeLast();
      } else {
        resultLetters.add(letters[i]);
      }
    }

    return resultLetters.join();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({
    required this.s,
    required super.result,
  });

  final String s;

  @override
  String computeResult() => Solution().clearDigits(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: 'abc', result: 'abc'),
    SolutionTest(s: 'cb3wq', result: 'cwq'),
    SolutionTest(s: '3abc', result: '3abc'),
    SolutionTest(s: 'cb34', result: ''),
  ].test();
}
