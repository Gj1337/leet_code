// You are given a 2D integer grid of size m x n and an integer x. In one operation, you can add x to or subtract x from any element in the grid.
// A uni-value grid is a grid where all the elements of it are equal.
// Return the minimum number of operations to make the grid uni-value. If it is not possible, return -1.

// Example 1:
// Input: grid = [[2,4],[6,8]], x = 2
// Output: 4
// Explanation: We can make every element equal to 4 by doing the following:
// - Add x to 2 once.
// - Subtract x from 6 once.
// - Subtract x from 8 twice.
// A total of 4 operations were used.

// Example 2:
// Input: grid = [[1,5],[2,3]], x = 1
// Output: 5
// Explanation: We can make every element equal to 3.

// Example 3:
// Input: grid = [[1,2],[3,4]], x = 2
// Output: -1
// Explanation: It is impossible to make every element equal.

// Constraints:
// m == grid.length
// n == grid[i].length
// 1 <= m, n <= 105
// 1 <= m * n <= 105
// 1 <= x, grid[i][j] <= 104

import 'testable.dart';

class Solution {
  int minOperations(List<List<int>> grid, int x) {
    final list = grid.expand((e) => e).toList();

    final mod = list[0] % x;
    for (final num in list) {
      if (num % x != mod) return -1;
    }

    list.sort();
    final median = list[list.length ~/ 2];

    return list.fold(0, (p, n) => p += (n - median).abs() ~/ x);
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> grid;
  final int x;

  SolutionTest({required this.grid, required this.x, required super.result});

  @override
  int computeResult() => Solution().minOperations(grid, x);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        [2, 4],
        [6, 8],
      ],
      x: 2,
      result: 4,
    ),
    SolutionTest(
      grid: [
        [1, 5],
        [2, 3],
      ],
      x: 1,
      result: 5,
    ),
    SolutionTest(
      grid: [
        [1, 2],
        [3, 4],
      ],
      x: 2,
      result: -1,
    ),
    SolutionTest(
      grid: [
        [146],
      ],
      x: 86,
      result: 0,
    ),
    SolutionTest(
      grid: [
        [931, 128],
        [639, 712],
      ],
      x: 73,
      result: 12,
    ),
  ].test();
}
