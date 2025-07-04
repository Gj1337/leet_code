// You are given a string s of lowercase English letters
// and an integer array shifts of the same length.
// Call the shift() of a letter, the next letter in the alphabet,
// (wrapping around so that 'z' becomes 'a').
//     For example, shift('a') = 'b', shift('t') = 'u',
// and shift('z') = 'a'.
// Now for each shifts[i] = x, we want to shift
// the first i + 1 letters of s, x times.
// Return the final string after all such shifts to s are applied.

// Example 1:

// Input: s = "abc", shifts = [3,5,9]
// Output: "rpl"
// Explanation: We start with "abc".
// After shifting the first 1 letters of s by 3, we have "dbc".
// After shifting the first 2 letters of s by 5, we have "igc".
// After shifting the first 3 letters of s by 9, we have "rpl", the answer.

// Example 2:
// Input: s = "aaa", shifts = [1,2,3]
// Output: "gfd"

// Constraints:
//     1 <= s.length <= 105
//     s consists of lowercase English letters.
//     shifts.length == s.length
//     0 <= shifts[i] <= 109

import 'testable.dart';

const alphabet = 'abcdefghijklmnopqrstuvwxyz';

class Solution {
  String shiftingLetters(String s, List<int> shifts) {
    var totalShifts = <int>[];
    var additionalShift = 0;

    for (var i = shifts.length - 1; i >= 0; i--) {
      totalShifts.add((shifts[i] + additionalShift));

      additionalShift += shifts[i];
    }
    totalShifts = totalShifts.reversed.toList();

    final chars = s.split('');
    var newS = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final charIndex = alphabet.indexOf(chars[i]);
      final newCharIndex = (totalShifts[i] + charIndex) % alphabet.length;

      newS.write(alphabet[newCharIndex]);
    }

    return newS.toString();
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String s;
  final List<int> shifts;

  SolutionTest({required this.s, required this.shifts, required super.result});

  @override
  String computeResult() => Solution().shiftingLetters(s, shifts);
}

void main(List<String> args) {
  [
    SolutionTest(s: 'abc', shifts: [3, 5, 9], result: 'rpl'),
    SolutionTest(s: 'aaa', shifts: [1, 2, 3], result: 'gfd'),
  ].test();
}
