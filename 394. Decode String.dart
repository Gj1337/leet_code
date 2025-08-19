// Given an encoded string, return its decoded string.
// The encoding rule is: k[encoded_string],
//  where the encoded_string inside the square brackets
// is being repeated exactly k times. Note that k
// is guaranteed to be a positive integer.
// You may assume that the input string is always valid;
// there are no extra white spaces, square brackets are well-formed,
// etc. Furthermore, you may assume that
// the original data does not contain any digits and
// that digits are only for those repeat numbers, k.
// For example, there will not be input like 3a or 2[4].
// The test cases are generated so that the length of
// the output will never exceed 105.

// Example 1:
// Input: s = "3[a]2[bc]"
// Output: "aaabcbc"

// Example 2:
// Input: s = "3[a2[c]]"
// Output: "accaccacc"

// Example 3:
// Input: s = "2[abc]3[cd]ef"
// Output: "abcabccdcdcdef"

// Constraints:
//     1 <= s.length <= 30
//     s consists of lowercase English letters, digits,
// and square brackets '[]'.
//     s is guaranteed to be a valid input.
//     All the integers in s are in the range [1, 300].

// "3[a2[c]]2[ab]"

import 'testable.dart';

const numbers = <String, int>{
  '0': 0,
  '1': 1,
  '2': 2,
  '3': 3,
  '4': 4,
  '5': 5,
  '6': 6,
  '7': 7,
  '8': 8,
  '9': 9,
};

class Solution {
  String decodeString(String s) {
    final stringStack = <String>[];
    final multiplierStack = <int>[];

    var currentMultiplier = 0;
    var currentString = '';

    print(s);

    for (var i = 0; i < s.length; i++) {
      final digit = numbers[s[i]];

      if (digit != null) {
        currentMultiplier = currentMultiplier * 10 + digit;
      } else if (s[i] == '[') {
        multiplierStack.add(currentMultiplier);
        currentMultiplier = 0;

        stringStack.add(currentString);
        currentString = '';
      } else if (s[i] == ']') {
        currentString = stringStack.removeLast() +
            currentString * multiplierStack.removeLast();
      } else {
        currentString = currentString + s[i];
      }

      print('char ${s[i]}');
      print('currentString "$currentString"');
      print('currentMultiplier $currentMultiplier');
      print('stringStack $stringStack');
      print('multiplierStack $multiplierStack');
      print('');
    }

    return currentString;
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({required this.s, required super.result});

  final String s;

  @override
  String computeResult() =>
      Solution().decodeString(s); // TODO: implement computeResult
}

void main(List<String> args) {
  [
    SolutionTest(s: "3[a]2[bc]", result: "aaabcbc"),
    SolutionTest(s: "3[a2[c]]", result: "accaccacc"),
    SolutionTest(s: "2[abc]3[cd]ef", result: "abcabccdcdcdef"),
  ].test();
}
