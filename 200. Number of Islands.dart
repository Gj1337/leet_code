// Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.
//
// An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
//
// Example 1:
// Input: grid = [
//   ["1","1","1","1","0"],
//   ["1","1","0","1","0"],
//   ["1","1","0","0","0"],
//   ["0","0","0","0","0"]
// ]
// Output: 1
//
// Example 2:
// Input: grid = [
//   ["1","1","0","0","0"],
//   ["1","1","0","0","0"],
//   ["0","0","1","0","0"],
//   ["0","0","0","1","1"]
// ]
// Output: 3
//
// Constraints:
//
//     m == grid.length
//     n == grid[i].length
//     1 <= m, n <= 300
//     grid[i][j] is '0' or '1'.

import 'testable.dart';

class Solution {
  int numIslands(List<List<String>> grid) {
    var result = 0;
    final stack = <(int i, int j)>[];

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == '1') {
          result++;
          stack.add((i, j));
        }

        while (stack.isNotEmpty) {
          final (ni, nj) = stack.removeLast();
          grid[ni][nj] = '0';

          stack.addAll([
            if (ni > 0 && grid[ni - 1][nj] == '1') (ni - 1, nj),
            if (ni < grid.length - 1 && grid[ni + 1][nj] == '1') (ni + 1, nj),
            if (nj > 0 && grid[ni][nj - 1] == '1') (ni, nj - 1),
            if (nj < grid[i].length - 1 && grid[ni][nj + 1] == '1')
              (ni, nj + 1),
          ]);
        }
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<String>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().numIslands(grid);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        ["1", "1", "1", "1", "0"],
        ["1", "1", "0", "1", "0"],
        ["1", "1", "0", "0", "0"],
        ["0", "0", "0", "0", "0"]
      ],
      result: 1,
    ),
    SolutionTest(
      grid: [
        ["1", "1", "0", "0", "0"],
        ["1", "1", "0", "0", "0"],
        ["0", "0", "1", "0", "0"],
        ["0", "0", "0", "1", "1"]
      ],
      result: 3,
    ),
    SolutionTest(grid: [
      ["1", "0", "1", "1", "0", "1", "1"]
    ], result: 3),
    SolutionTest(grid: [
      ["1"],
      ["1"],
      ["0"],
      ["1"],
      ["0"],
      ["1"]
    ], result: 3)
  ].test();
}
