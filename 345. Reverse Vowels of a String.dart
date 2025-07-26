// Given a string s, reverse only all the vowels in the string and return it.
// The vowels are 'a', 'e', 'i', 'o', and 'u',
// and they can appear in both lower and upper cases, more than once.

// Example 1:
// Input: s = "IceCreAm"
// Output: "AceCreIm"
// Explanation:
// The vowels in s are ['I', 'e', 'e', 'A']. On reversing the vowels,
// s becomes "AceCreIm".

// Example 2:
// Input: s = "leetcode"
// Output: "leotcede"

// Constraints:
//     1 <= s.length <= 3 * 105
//     s consist of printable ASCII characters.

import 'testable.dart';

const vowels = {'a', 'A', 'e', 'E', 'i', 'I', 'o', 'O', 'u', 'U'};

class Solution {
  String reverseVowels(String s) {
    var forwardPointer = 0;
    var backwardPointer = s.length - 1;

    final chars = s.split('');

    while (forwardPointer < backwardPointer) {
      if (vowels.contains(chars[forwardPointer])) {
        while (true) {
          if (backwardPointer == forwardPointer) break;

          if (vowels.contains(chars[backwardPointer])) {
            final temp = chars[forwardPointer];
            chars[forwardPointer] = chars[backwardPointer];
            chars[backwardPointer] = temp;
            backwardPointer--;
            break;
          }

          backwardPointer--;
        }
      }

      forwardPointer++;
    }

    return chars.join();
  }
}

class SolutionTest extends Testable with ConsoleTestOutput {
  SolutionTest({required this.s, required super.result});

  final String s;

  @override
  computeResult() => Solution().reverseVowels(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "IceCreAm", result: "AceCreIm"),
    SolutionTest(s: "leetcode", result: "leotcede"),
  ].test();
}
