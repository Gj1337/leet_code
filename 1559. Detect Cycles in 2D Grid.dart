// Given a 2D array of characters grid of size m x n, you need to find if there exists any cycle consisting of the same value in grid.
// A cycle is a path of length 4 or more in the grid that starts and ends at the same cell. From a given cell, you can move to one of the cells adjacent to it - in one of the four directions (up, down, left, or right), if it has the same value of the current cell.
// Also, you cannot move to the cell that you visited in your last move. For example, the cycle (1, 1) -> (1, 2) -> (1, 1) is invalid because from (1, 2) we visited (1, 1) which was the last visited cell.
// Return true if any cycle of the same value exists in grid, otherwise, return false.

// Example 1:
// Input: grid = [["a","a","a","a"],["a","b","b","a"],["a","b","b","a"],["a","a","a","a"]]
// Output: true
// Explanation: There are two valid cycles shown in different colors in the image below:

// Example 2:
// Input: grid = [["c","c","c","a"],["c","d","c","c"],["c","c","e","c"],["f","c","c","c"]]
// Output: true
// Explanation: There is only one valid cycle highlighted in the image below:

// Example 3:
// Input: grid = [["a","b","b"],["b","z","b"],["b","b","a"]]
// Output: false

import 'testable.dart';

class Solution {
  bool containsCycle(List<List<String>> grid) {
    final visitGrid = List.generate(
      grid.length,
      (index) => List.filled(grid[index].length, false),
    );

    bool dfs(int si, int sj, String char) {
      final stack = <(int, int, int?, int?)>[];
      stack.add((si, sj, null, null));

      while (stack.isNotEmpty) {
        final (i, j, pi, pj) = stack.removeLast();

        if (visitGrid[i][j]) return true;
        visitGrid[i][j] = true;

        final canGoDown =
            i < grid.length - 1 && i + 1 != pi && grid[i + 1][j] == char;
        if (canGoDown) stack.add((i + 1, j, i, j));

        final canGoRight =
            j < grid[i].length - 1 && j + 1 != pj && grid[i][j + 1] == char;
        if (canGoRight) stack.add((i, j + 1, i, j));

        final canGoUp = i > 0 && i - 1 != pi && grid[i - 1][j] == char;
        if (canGoUp) stack.add((i - 1, j, i, j));

        final canGoLeft = j > 0 && j - 1 != pj && grid[i][j - 1] == char;
        if (canGoLeft) stack.add((i, j - 1, i, j));
      }

      return false;
    }

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (!visitGrid[i][j] && dfs(i, j, grid[i][j])) {
          return true;
        }
      }
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<List<String>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  bool computeResult() => Solution().containsCycle(grid);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        ["a", "a", "a", "a"],
        ["a", "b", "b", "a"],
        ["a", "b", "b", "a"],
        ["a", "a", "a", "a"],
      ],
      result: true,
    ),

    SolutionTest(
      grid: [
        ["c", "c", "c", "a"],
        ["c", "d", "c", "c"],
        ["c", "c", "e", "c"],
        ["f", "c", "c", "c"],
      ],
      result: true,
    ),
    SolutionTest(
      grid: [
        ["a", "b", "b"],
        ["b", "z", "b"],
        ["b", "b", "a"],
      ],
      result: false,
    ),
    SolutionTest(
      grid: [
        ["d", "b", "b"],
        ["c", "a", "a"],
        ["b", "a", "c"],
        ["c", "c", "c"],
        ["d", "d", "a"],
      ],
      result: false,
    ),
  ].test();
}
