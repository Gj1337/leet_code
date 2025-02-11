// Given two strings s and part, perform the following operation on s
// until all occurrences of the substring part are removed:
//  Find the leftmost occurrence of the substring part
// and remove it from s.
// Return s after removing all occurrences of part.

// A substring is a contiguous sequence of characters in a string.

// Example 1:
// Input: s = "daabcbaabcbc", part = "abc"
// Output: "dab"
// Explanation: The following operations are done:
// - s = "daabcbaabcbc", remove "abc" starting at index 2, so s = "dabaabcbc".
// - s = "dabaabcbc", remove "abc" starting at index 4, so s = "dababc".
// - s = "dababc", remove "abc" starting at index 3, so s = "dab".
// Now s has no occurrences of "abc".

// Example 2:
// Input: s = "axxxxyyyyb", part = "xy"
// Output: "ab"
// Explanation: The following operations are done:
// - s = "axxxxyyyyb", remove "xy" starting at index 4 so s = "axxxyyyb".
// - s = "axxxyyyb", remove "xy" starting at index 3 so s = "axxyyb".
// - s = "axxyyb", remove "xy" starting at index 2 so s = "axyb".
// - s = "axyb", remove "xy" starting at index 1 so s = "ab".
// Now s has no occurrences of "xy".

// Constraints:
//     1 <= s.length <= 1000
//     1 <= part.length <= 1000
//     s​​​​​​ and part consists of lowercase English letters.

import 'testable.dart';

class Solution {
  String removeOccurrences(String s, String part) {
    final letters = s.split('');
    
    var result = '';

    for (var i = 0; i < letters.length; i++) {
      result = '$result${letters[i]}';

      if (result.endsWith(part)) {
        result = result.replaceRange(
          result.length - part.length,
          null,
          '',
        );
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String s;
  final String part;

  SolutionTest({
    required this.s,
    required this.part,
    required super.result,
  });

  @override
  String computeResult() => Solution().removeOccurrences(s, part);
}

void main(List<String> args) {
  [
    SolutionTest(s: 'daabcbaabcbc', part: 'abc', result: 'dab'),
  ].test();
}
