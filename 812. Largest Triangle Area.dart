// Given an array of points on the X-Y plane points where points[i] = [xi, yi],
// return the area of the largest triangle
// that can be formed by any three different points.
// Answers within 10-5 of the actual answer will be accepted.

// Example 1:
// Input: points = [[0,0],[0,1],[1,0],[0,2],[2,0]]
// Output: 2.00000
// Explanation: The five points are shown in the above figure.
// The red triangle is the largest.

// Example 2:
// Input: points = [[1,0],[0,0],[0,1]]
// Output: 0.50000

// Constraints:
//     3 <= points.length <= 50
//     -50 <= xi, yi <= 50
//     All the given points are unique.

import 'testable.dart';

class Solution {
  double largestTriangleArea(List<List<int>> points) {
    //Shoelace's Formula
    double calculateArea(int x1, y1, x2, y2, x3, y3) =>
        0.5 * ((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)).abs());

    var largestArea = 0.0;

    for (var point1 in points) {
      for (var point2 in points) {
        for (var point3 in points) {
          final (x1, y1, x2, y2, x3, y3) = (
            point1.first,
            point1.last,
            point2.first,
            point2.last,
            point3.first,
            point3.last
          );

          final currentArea = calculateArea(x1, y1, x2, y2, x3, y3);

          largestArea = currentArea > largestArea ? currentArea : largestArea;
        }
      }
    }

    return largestArea;
  }
}

class SolutionTest extends Testable<double> with ConsoleTestOutput {
  final List<List<int>> points;

  SolutionTest({required this.points, required super.result});

  @override
  double computeResult() => Solution().largestTriangleArea(points);
}

void main(List<String> args) {
  [
    SolutionTest(points: [
      [0, 0],
      [0, 1],
      [1, 0],
      [0, 2],
      [2, 0]
    ], result: 2.00000),
    SolutionTest(points: [
      [1, 0],
      [0, 0],
      [0, 1]
    ], result: 0.50000)
  ].test();
}
