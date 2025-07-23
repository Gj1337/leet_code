// For two strings s and t,
// we say "t divides s" if and only if
// s = t + t + t + ... + t + t
//(i.e., t is concatenated with itself one or more times).
// Given two strings str1 and str2,
// return the largest string x such that x divides both str1 and str2.

// Example 1:
// Input: str1 = "ABCABC", str2 = "ABC"
// Output: "ABC"

// Example 2:
// Input: str1 = "ABABAB", str2 = "ABAB"
// Output: "AB"

// Example 3:
// Input: str1 = "LEET", str2 = "CODE"
// Output: ""

// Constraints:
//     1 <= str1.length, str2.length <= 1000
//     str1 and str2 consist of English uppercase letters.

import 'testable.dart';

class Solution {
  int gcd(int a, int b) {
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }

    return a;
  }

  String gcdOfStrings(String str1, String str2) => (str1 + str2 == str2 + str1)
      ? str1.substring(0, gcd(str1.length, str2.length))
      : "";

  // String gcdOfStrings(String str1, String str2) {
  //   var (shortLine, longLine) =
  //       str1.length < str2.length ? (str1, str2) : (str2, str1);
  //   var possiblePrefix = "";

  //   for (var i = 0; i < shortLine.length; i++) {
  //     if (str1[i] == str2[i]) {
  //       possiblePrefix += str1[i];
  //     } else {
  //       break;
  //     }
  //   }

  //   while (possiblePrefix.isNotEmpty) {
  //     final canFit = (shortLine.length % possiblePrefix.length) == 0 &&
  //         (longLine.length % possiblePrefix.length) == 0;

  //     if (canFit) {
  //       var fits = true;

  //       for (var i = 0; i < longLine.length; i += possiblePrefix.length) {
  //         final longLineFits =
  //             longLine.substring(i, i + possiblePrefix.length) ==
  //                 possiblePrefix;

  //         final shortLineFits = i + possiblePrefix.length <= shortLine.length
  //             ? shortLine.substring(i, i + possiblePrefix.length) ==
  //                 possiblePrefix
  //             : true;

  //         if (!(shortLineFits && longLineFits)) {
  //           fits = false;

  //           break;
  //         }
  //       }

  //       if (fits) return possiblePrefix;
  //     }

  //     possiblePrefix = possiblePrefix.substring(0, possiblePrefix.length - 1);
  //   }

  //   return "";
  // }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({
    required this.str1,
    required this.str2,
    required super.result,
  });

  final String str1;
  final String str2;

  @override
  String computeResult() => Solution().gcdOfStrings(str1, str2);
}

void main(List<String> args) {
  [
    SolutionTest(str1: "ABCABC", str2: "ABC", result: "ABC"),
    SolutionTest(str1: "ABABAB", str2: "ABAB", result: "AB"),
    SolutionTest(str1: "LEET", str2: "CODE", result: ""),
    SolutionTest(str1: "ABCDEF", str2: "ABC", result: ""),
  ].test();
}
