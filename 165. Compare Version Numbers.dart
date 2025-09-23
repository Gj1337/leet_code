// Given two version strings, version1 and version2, compare them.
// A version string consists of revisions separated by dots '.'.
// The value of the revision is its integer conversion ignoring leading zeros.
// To compare version strings,
// compare their revision values in left-to-right order.
// If one of the version strings has fewer revisions,
// treat the missing revision values as 0.
// Return the following:
//     If version1 < version2, return -1.
//     If version1 > version2, return 1.
//     Otherwise, return 0.

// Example 1:
// Input: version1 = "1.2", version2 = "1.10"
// Output: -1
// Explanation:
// version1's second revision is "2" and
// version2's second revision is "10": 2 < 10, so version1 < version2.

// Example 2:
// Input: version1 = "1.01", version2 = "1.001"
// Output: 0
// Explanation:
// Ignoring leading zeroes, both "01" and "001" represent the same integer "1".

// Example 3:
// Input: version1 = "1.0", version2 = "1.0.0.0"
// Output: 0
// Explanation:
// version1 has less revisions,
// which means every missing revision are treated as "0".

// Constraints:
//     1 <= version1.length, version2.length <= 500
//     version1 and version2 only contain digits and '.'.
//     version1 and version2 are valid version numbers.
//     All the given revisions in version1 and version2
//                   can be stored in a 32-bit integer.

import 'testable.dart';

class Solution {
  int compareVersion(String version1, String version2) {
    var point1 = 0;
    var point2 = 0;

    while (point1 < version1.length || point2 < version2.length) {
      var currentGroup1 = "0";
      while (point1 < version1.length && version1[point1] != '.') {
        currentGroup1 = currentGroup1 + version1[point1];
        point1++;
      }
      point1++;
      final currentNumber1 = int.parse(currentGroup1);

      var currentGroup2 = "0";
      while (point2 < version2.length && version2[point2] != '.') {
        currentGroup2 = currentGroup2 + version2[point2];
        point2++;
      }
      point2++;
      final currentNumber2 = int.parse(currentGroup2);

      final groupeCompare = currentNumber1.compareTo(currentNumber2);
      if (groupeCompare != 0) return groupeCompare;
    }

    return 0;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String version1;
  final String version2;

  SolutionTest({
    required this.version1,
    required this.version2,
    required super.result,
  });

  @override
  int computeResult() => Solution().compareVersion(version1, version2);
}

void main(List<String> args) {
  [
    SolutionTest(version1: "1.0.1", version2: "1", result: 1),
    SolutionTest(version1: "1.2", version2: "1.10", result: -1),
    SolutionTest(version1: "1.01", version2: "1.001", result: 0),
    SolutionTest(version1: "1.0", version2: "1.0.0.0", result: 0),
  ].test();
}
