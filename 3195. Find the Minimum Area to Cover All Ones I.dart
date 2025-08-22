// You are given a 2D binary array grid.
// Find a rectangle with horizontal and vertical sides with the smallest area,
// such that all the 1's in grid lie inside this rectangle.
// Return the minimum possible area of the rectangle.

// Example 1:
// Input: grid = [[0,1,0],[1,0,1]]
// Output: 6
// Explanation:
// The smallest rectangle has a height of 2 and a width of 3, so it has an area of 2 * 3 = 6.

// Example 2:
// Input: grid = [[1,0],[0,0]]
// Output: 1
// Explanation:
// The smallest rectangle has both height and width 1, so its area is 1 * 1 = 1.

// Constraints:
//     1 <= hight, grid[i].length <= 1000
//     grid[i][j] is either 0 or 1.
//     The input is generated such that there is at least one 1 in grid.

import 'testable.dart';

class Solution {
  int minimumArea(List<List<int>> grid) {
    final hight = grid.length;
    final width = grid.first.length;

    var breaker = false;
    var top = -1;
    for (var i = 0; i < hight; i++) {
      for (var j = 0; j < width; j++) {
        if (grid[i][j] == 1) {
          top = i + 1;
          breaker = true;
          break;
        }
      }
      if (breaker) break;
    }

    // if there is no 1 in grid
    if (top < 0) return 0;

    breaker = false;
    var bottom = -1;
    for (var i = hight - 1; i >= 0; i--) {
      for (var j = 0; j < width; j++) {
        if (grid[i][j] == 1) {
          bottom = i + 1;
          breaker = true;
          break;
        }
      }

      if (breaker) break;
    }

    breaker = false;
    var left = -1;
    for (var j = 0; j < width; j++) {
      for (var i = 0; i < hight; i++) {
        if (grid[i][j] == 1) {
          left = j + 1;
          breaker = true;
          break;
        }
      }

      if (breaker) break;
    }

    breaker = false;
    var right = -1;
    for (var j = width - 1; j >= 0; j--) {
      for (var i = 0; i < hight; i++) {
        if (grid[i][j] == 1) {
          right = j + 1;
          breaker = true;
          break;
        }
      }
      if (breaker) break;
    }

    final areaHight = bottom - top + 1;
    final areaWidth = right - left + 1;

    return areaWidth * areaHight;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().minimumArea(grid);
}

void main(List<String> args) {
  [
    SolutionTest(grid: [
      [0, 1, 0],
      [1, 0, 1]
    ], result: 6),
    SolutionTest(grid: [
      [1, 0],
      [0, 0]
    ], result: 1)
  ].test();
}
