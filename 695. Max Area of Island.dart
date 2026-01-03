// You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.
// The area of an island is the number of cells with a value 1 in the island.
// Return the maximum area of an island in grid. If there is no island, return 0.
//
// Example 1:
// Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
// Output: 6
// Explanation: The answer is not 11, because the island must be connected 4-directionally.
//
// Example 2:
// Input: grid = [[0,0,0,0,0,0,0,0]]
// Output: 0
//
// Constraints:
// m == grid.length
// n == grid[i].length
// 1 <= m, n <= 50
// grid[i][j] is either 0 or 1.

import 'testable.dart';

class Solution {
  int maxAreaOfIsland(List<List<int>> grid) {
    var maxArea = 0;

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 1) {
          var currentArea = 1;

          final stack = <(int i, int j)>[(i, j)];
          grid[i][j] = 0;

          while (stack.isNotEmpty) {
            final (i, j) = stack.removeLast();

            if (i > 0 && grid[i - 1][j] == 1) {
              currentArea++;
              stack.add((i - 1, j));
              grid[i - 1][j] = 0;
            }
            if (i < grid.length - 1 && grid[i + 1][j] == 1) {
              currentArea++;
              stack.add((i + 1, j));
              grid[i + 1][j] = 0;
            }
            if (j > 0 && grid[i][j - 1] == 1) {
              currentArea++;
              stack.add((i, j - 1));
              grid[i][j - 1] = 0;
            }
            if (j < grid[i].length - 1 && grid[i][j + 1] == 1) {
              currentArea++;
              stack.add((i, j + 1));
              grid[i][j + 1] = 0;
            }
          }

          maxArea = currentArea > maxArea ? currentArea : maxArea;
        }
      }
    }

    return maxArea;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().maxAreaOfIsland(grid);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0],
        [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
      ],
      result: 6,
    ),
    SolutionTest(
      grid: [
        [0, 0, 0, 0, 0, 0, 0, 0],
      ],
      result: 0,
    ),
  ].test();
}
