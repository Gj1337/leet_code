// An axis-aligned rectangle is represented as a list [x1, y1, x2, y2], where (x1, y1) is the coordinate of its bottom-left corner, and (x2, y2) is the coordinate of its top-right corner. Its top and bottom edges are parallel to the X-axis, and its left and right edges are parallel to the Y-axis.
// Two rectangles overlap if the area of their intersection is positive. To be clear, two rectangles that only touch at the corner or edges do not overlap.
// Given two axis-aligned rectangles rec1 and rec2, return true if they overlap, otherwise return false.
//
// Example 1:
// Input: rec1 = [0,0,2,2], rec2 = [1,1,3,3]
// Output: true
//
// Example 2:
// Input: rec1 = [0,0,1,1], rec2 = [1,0,2,1]
// Output: false
//
// Example 3:
// Input: rec1 = [0,0,1,1], rec2 = [2,2,3,3]
// Output: false
//
// Constraints:
// rec1.length == 4
// rec2.length == 4
// -109 <= rec1[i], rec2[i] <= 109
// rec1 and rec2 represent a valid rectangle with a non-zero area.

import 'testable.dart';

class Solution {
  bool isRectangleOverlap(List<int> rec1, List<int> rec2) {
    final [r1x1, r1y1, r1x2, r1y2] = rec1;
    final [r2x1, r2y1, r2x2, r2y2] = rec2;

    final firstRecIsLine = (r1x1 == r1x2) || (r1y1 == r1y2);
    final secondRecIsAline = (r2x1 == r2x2) || (r2y1 == r2y2);

    if (firstRecIsLine || secondRecIsAline) return false;

    final rec2OnTheLeft = r2x2 <= r1x1;
    final rec2OnTheRight = r2x1 >= r1x2;
    final rec2OnTheTop = r2y2 <= r1y1;
    final rec2OnTheBottom = r2y1 >= r1y2;

    return !(rec2OnTheLeft ||
        rec2OnTheRight ||
        rec2OnTheTop ||
        rec2OnTheBottom);
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<int> rec1;
  final List<int> rec2;

  SolutionTest({required this.rec1, required this.rec2, required super.result});

  @override
  bool computeResult() => Solution().isRectangleOverlap(rec1, rec2);
}

void main(List<String> args) {
  [
    SolutionTest(rec1: [0, 0, 2, 2], rec2: [1, 1, 3, 3], result: true),
    SolutionTest(rec1: [0, 0, 1, 1], rec2: [1, 0, 2, 1], result: false),
    SolutionTest(rec1: [0, 0, 1, 1], rec2: [2, 2, 3, 3], result: false),
    SolutionTest(rec1: [4, 4, 14, 7], rec2: [4, 3, 8, 8], result: true),
  ].test();
}
