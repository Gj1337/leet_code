// You are given row x col grid representing a map where grid[i][j] = 1 represents land and grid[i][j] = 0 represents water.
//
// Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).
//
// The island doesn't have "lakes", meaning the water inside isn't connected to the water around the island. One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.
//
// Example 1:
// 	Input: grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
// 	Output: 16
// 	Explanation: The perimeter is the 16 yellow stripes in the image above.
//
// Example 2:
// 	Input: grid = [[1]]
// 	Output: 4
//
// Example 3:
// 	Input: grid = [[1,0]]
// 	Output: 4
//
// Constraints:
// 	row == grid.length
// 	col == grid[i].length
// 	1 <= row, col <= 100
// 	grid[i][j] is 0 or 1.
//
// There is exactly one island in grid.

import 'testable.dart';

class Solution {
  int islandPerimeter(List<List<int>> grid) {
    var sum = 0;

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 1) {
          sum += 4;
          if (i < grid.length - 1 && grid[i + 1][j] == 1) sum -= 2;
          if (j < grid[i].length - 1 && grid[i][j + 1] == 1) sum -= 2;
        }
      }
    }

    return sum;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().islandPerimeter(grid);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        [0, 1, 0, 0],
        [1, 1, 1, 0],
        [0, 1, 0, 0],
        [1, 1, 0, 0],
      ],
      result: 16,
    ),
    SolutionTest(
      grid: [
        [1],
      ],
      result: 4,
    ),
    SolutionTest(
      grid: [
        [1, 0],
      ],
      result: 4,
    ),
  ].test();
}
