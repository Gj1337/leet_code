// Given a string containing digits from 2-9 inclusive,
// return all possible letter combinations that the number could represent.
// Return the answer in any order.
// A mapping of digits to letters (just like on the telephone buttons)
// is given below. Note that 1 does not map to any letters.

// Example 1:
// Input: digits = "23"
// Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

// Example 2:
// Input: digits = ""
// Output: []

// Example 3:
// Input: digits = "2"
// Output: ["a","b","c"]

// Constraints:
//     0 <= digits.length <= 4
//     digits[i] is a digit in the range ['2', '9'].

import 'testable.dart';

const keyboardMap = {
  '1': [''],
  '2': ['a', 'b', 'c'],
  '3': ['d', 'e', 'f'],
  '4': ['g', 'h', 'i'],
  '5': ['j', 'k', 'l'],
  '6': ['m', 'n', 'o'],
  '7': ['p', 'q', 'r', 's'],
  '8': ['t', 'u', 'v'],
  '9': ['w', 'x', 'y', 'z'],
  '*': ['+'],
  '0': [' '],
  '#': ['#']
};

class Solution {
  List<String> letterCombinations(String digits) {
    final result = <String>[];
    if (digits.isEmpty) return result;

    void backTrack(int index, String currentString) {
      if (index == digits.length) {
        result.add(currentString);
        return;
      }

      final digit = digits[index];
      for (final char in keyboardMap[digit]!) {
        backTrack(index + 1, currentString + char);
      }
    }

    backTrack(0, '');

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final String digits;

  SolutionTest({required this.digits, required super.result});

  @override
  List<String> computeResult() => Solution().letterCombinations(digits);

  @override
  bool validateResult(
      List<String> computedResult, List<String> expectedResult) {
    if (computedResult.length != expectedResult.length) return false;
    for (final combination in computedResult) {
      if (!expectedResult.contains(combination)) return false;
    }

    return true;
  }
}

void main(List<String> args) {
  [
    SolutionTest(
        digits: '23',
        result: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]),
    SolutionTest(digits: '', result: []),
    SolutionTest(digits: '2', result: ["a", "b", "c"])
  ].test();
}
