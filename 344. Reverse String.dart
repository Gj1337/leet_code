// Write a function that reverses a string.
// The input string is given as an array of characters s.
// You must do this by modifying the input array in-place
// with O(1) extra memory.

// Example 1:
// Input: s = ["h","e","l","l","o"]
// Output: ["o","l","l","e","h"]

// Example 2:
// Input: s = ["H","a","n","n","a","h"]
// Output: ["h","a","n","n","a","H"]

// Constraints:
//     1 <= s.length <= 105
//     s[i] is a printable ascii character.

import 'testable.dart';

class Solution {
  void reverseString(List<String> s) {
    for (var i = 0; i < s.length ~/ 2; i++) {
      final temp = s[i];
      s[i] = s[s.length - i - 1];
      s[s.length - i - 1] = temp;
    }
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  SolutionTest({required this.s, required super.result});

  final List<String> s;

  @override
  List<String> computeResult() {
    Solution().reverseString(s);

    return s;
  }
}

void main(List<String> args) {
  [
    SolutionTest(
        s: ["h", "e", "l", "l", "o"], result: ["o", "l", "l", "e", "h"]),
  ].test();
}
