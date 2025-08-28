// You are given an n x n square matrix of integers grid.
// Return the matrix such that:
//     The diagonals in the bottom-left triangle (including the middle diagonal)
//     are sorted in non-increasing order.
//     The diagonals in the top-right triangle
//     are sorted in non-decreasing order.

// Example 1:
// Input: grid = [[1,7,3],[9,8,2],[4,5,6]]
// Output: [[8,2,3],[9,6,7],[4,5,1]]
// Explanation:
// The diagonals with a black arrow (bottom-left triangle)
// should be sorted in non-increasing order:
//     [1, 8, 6] becomes [8, 6, 1].
//     [9, 5] and [4] remain unchanged.
// The diagonals with a blue arrow (top-right triangle)
// should be sorted in non-decreasing order:
//     [7, 2] becomes [2, 7].
//     [3] remains unchanged.

// Example 2:
// Input: grid = [[0,1],[1,2]]
// Output: [[2,1],[1,0]]
// Explanation:
// The diagonals with a black arrow must be non-increasing,
// so [0, 2] is changed to [2, 0].
// The other diagonals are already in the correct order.

// Example 3:
// Input: grid = [[1]]
// Output: [[1]]
// Explanation:
// Diagonals with exactly one element are already in order,
// so no changes are needed.

// Constraints:
//     grid.length == grid[i].length == n
//     1 <= n <= 10
//     -105 <= grid[i][j] <= 105

import 'testable.dart';

class Solution {
  List<List<int>> sortMatrix(List<List<int>> grid) {
    //Bubble sort >_<
    void sortDiagonal({
      required (int i, int j) startPoint,
      bool ascending = true,
    }) {
      bool compare(int a, int b) => ascending ? a > b : a < b;

      var sorted = true;

      do {
        sorted = true;
        var (currentI, currentJ) = startPoint;

        while (currentI < grid.length - 1 && currentJ < grid.first.length - 1) {
          if (compare(
              grid[currentI][currentJ], grid[currentI + 1][currentJ + 1])) {
            final temp = grid[currentI][currentJ];
            grid[currentI][currentJ] = grid[currentI + 1][currentJ + 1];
            grid[currentI + 1][currentJ + 1] = temp;

            sorted = false;
          }

          (currentI++, currentJ++);
        }
      } while (!sorted);
    }

    var i = 0;
    var j = grid[i].length - 1;

    while (i < grid.length) {
      final ascending = !(i >= 0 && j == 0);
      sortDiagonal(startPoint: (i, j), ascending: ascending);

      j > 0 ? j-- : i++;
    }

    return grid;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<List<int>> grid;

  SolutionTest({required this.grid, required super.result});

  @override
  List<List<int>> computeResult() => Solution().sortMatrix(grid);
}

void main(List<String> args) {
  [
    SolutionTest(grid: [
      [1, 7, 3],
      [9, 8, 2],
      [4, 5, 6]
    ], result: [
      [8, 2, 3],
      [9, 6, 7],
      [4, 5, 1]
    ]),
    SolutionTest(grid: [
      [0, 1],
      [1, 2]
    ], result: [
      [2, 1],
      [1, 0]
    ]),
    SolutionTest(grid: [
      [1]
    ], result: [
      [1]
    ]),
  ].test();
}
