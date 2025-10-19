// Given a string s, reverse the string according to the following rules:
//     All the characters that are not English letters remain in the same position.
//     All the English letters (lowercase or uppercase) should be reversed.
//
// Return s after reversing it.
//
// Example 1:
// Input: s = "ab-cd"
// Output: "dc-ba"
//
// Example 2:
// Input: s = "a-bC-dEf-ghIj"
// Output: "j-Ih-gfE-dCba"
//
// Example 3:
// Input: s = "Test1ng-Leet=code-Q!"
// Output: "Qedo1ct-eeLg=ntse-T!"

import 'testable.dart';

class Solution {
  String reverseOnlyLetters(String s) {
    var startPointer = 0;
    var endPointer = s.length - 1;

    final chars = s.split('');

    bool isEnglishLetter(String char) => switch (char.codeUnitAt(0)) {
      >= 65 && <= 90 => true,
      >= 97 && <= 122 => true,
      _ => false,
    };

    while (startPointer < endPointer) {
      while (startPointer < s.length && !isEnglishLetter(chars[startPointer])) {
        startPointer++;
      }

      while (endPointer >= 0 && !isEnglishLetter(chars[endPointer])) {
        endPointer--;
      }

      if (startPointer < endPointer) {
        final temp = chars[startPointer];
        chars[startPointer] = chars[endPointer];
        chars[endPointer] = temp;
        startPointer++;
        endPointer--;
      }
    }

    return chars.join();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  String computeResult() => Solution().reverseOnlyLetters(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "ab-cd", result: "dc-ba"),
    SolutionTest(s: "a-bC-dEf-ghIj", result: "j-Ih-gfE-dCba"),
    SolutionTest(s: "Test1ng-Leet=code-Q!", result: "Qedo1ct-eeLg=ntse-T!"),
  ].test();
}
