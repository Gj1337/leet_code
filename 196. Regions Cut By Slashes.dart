// An n x n grid is composed of 1 x 1 squares where each 1 x 1 square consists of a '/', '\', or blank space ' '. These characters divide the square into contiguous regions.
//
// Given the grid grid represented as a string array, return the number of regions.
//
// Note that backslash characters are escaped, so a '\' is represented as '\\'.
//
// Example 1:
// Input: grid = [" /","/ "]
// Output: 2
//
// Example 2:
// Input: grid = [" /","  "]
// Output: 1
//
// Example 3:
// Input: grid = ["/\\","\\/"]
// Output: 5
// Explanation: Recall that because \ characters are escaped, "\\/" refers to \/, and "/\\" refers to /\.
//
// Constraints:
//
//     n == grid.length == grid[i].length
//     1 <= n <= 30
//     grid[i][j] is either '/', '\', or ' '.

import 'testable.dart';

class Solution {
  int regionsBySlashes(List<String> grid) {
    final maxtrix = List.generate(
        grid.length * 3, (_) => List.filled(grid.first.length * 3, 0));

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        switch (grid[i][j]) {
          case '/':
            maxtrix[i * 3][j * 3 + 2] = 1;
            maxtrix[i * 3 + 1][j * 3 + 1] = 1;
            maxtrix[i * 3 + 2][j * 3] = 1;
          case '\\':
            maxtrix[i * 3][j * 3] = 1;
            maxtrix[i * 3 + 1][j * 3 + 1] = 1;
            maxtrix[i * 3 + 2][j * 3 + 2] = 1;
        }
      }
    }

    var islandCount = 0;
    final stack = <(int, int)>[];

    for (var i = 0; i < maxtrix.length; i++) {
      for (var j = 0; j < maxtrix[i].length; j++) {
        if (maxtrix[i][j] == 0) {
          stack.add((i, j));
          islandCount++;
        }

        while (stack.isNotEmpty) {
          final (ni, nj) = stack.removeLast();
          maxtrix[ni][nj] = 1;

          stack.addAll([
            if (ni > 0 && maxtrix[ni - 1][nj] == 0) (ni - 1, nj),
            if (ni < maxtrix.length - 1 && maxtrix[ni + 1][nj] == 0)
              (ni + 1, nj),
            if (nj > 0 && maxtrix[ni][nj - 1] == 0) (ni, nj - 1),
            if (nj < maxtrix[i].length - 1 && maxtrix[ni][nj + 1] == 0)
              (ni, nj + 1),
          ]);
        }
      }
    }

    return islandCount;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<String> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().regionsBySlashes(grid);
}

void main(List<String> args) {
  [
    SolutionTest(grid: ["/ ", "/ "], result: 2),
    SolutionTest(grid: [" /", "  "], result: 1),
    SolutionTest(grid: ["/\\", "\\/"], result: 5)
  ].test();
}
