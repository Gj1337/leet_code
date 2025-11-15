// You are given an m x n grid where each cell can have one of three values:
//
// 0 representing an empty cell,
// 1 representing a fresh orange, or
// 2 representing a rotten orange.
// Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.
//
// Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.
//
// Example 1:
// Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
// Output: 4
//
// Example 2:
// Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
// Output: -1
// Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.
//
// Example 3:
// Input: grid = [[0,2]]
// Output: 0
// Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.
//
// Constraints:
// m == grid.length
// n == grid[i].length
// 1 <= m, n <= 10
// grid[i][j] is 0, 1, or 2.

import 'testable.dart';
import 'dart:collection';

class Solution {
  int orangesRotting(List<List<int>> grid) {
    var result = 0;

    bool possitionExist(int i, int j) =>
        i >= 0 && j >= 0 && i < grid.length && j < grid[i].length;

    bool canRot(int i, int j) => possitionExist(i, j) && grid[i][j] == 1;

    var freshCount = 0;
    final queue = Queue<(int i, int j)>();
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 2) {
          if (canRot(i - 1, j) ||
              canRot(i + 1, j) ||
              canRot(i, j + 1) ||
              canRot(i, j - 1)) {
            queue.add((i, j));
          }
        }

        if (grid[i][j] == 1) {
          freshCount++;
        }
      }
    }

    if (freshCount == 0) return 0;

    void rot(int i, int j) {
      if (canRot(i, j)) {
        grid[i][j] = 2;
        freshCount--;
        queue.add((i, j));
      }
    }

    while (queue.isNotEmpty) {
      result++;

      final queueLength = queue.length;
      for (var q = 0; q < queueLength; q++) {
        final (i, j) = queue.removeFirst();
        rot(i + 1, j);
        rot(i - 1, j);
        rot(i, j + 1);
        rot(i, j - 1);
      }
    }
    if (result > 0) result--;

    return freshCount == 0 ? result : -1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  List<List<int>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  int computeResult() => Solution().orangesRotting(grid);
}

void main(List<String> args) {
  [
    SolutionTest(grid: [
      [2, 1, 1],
      [1, 1, 0],
      [0, 1, 1]
    ], result: 4),
    SolutionTest(grid: [
      [2, 1, 1],
      [0, 1, 1],
      [1, 0, 1]
    ], result: -1),
    SolutionTest(grid: [
      [0, 2]
    ], result: 0),
  ].test();
}
