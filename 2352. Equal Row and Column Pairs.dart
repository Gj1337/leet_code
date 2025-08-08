// Given a 0-indexed n x n integer matrix grid,
// return the number of pairs (ri, cj) such that
// row ri and column cj are equal.
// A row and column pair is considered equal
// if they contain the same elements in the same order (i.e., an equal array).

// Example 1:
// Input: grid = [[3,2,1],
//                [1,7,6],
//                [2,7,7]]
// Output: 1
// Explanation: There is 1 equal row and column pair:
// - (Row 2, Column 1): [2,7,7]

// Example 2:
// Input: grid = [[3,1,2,2],[1,4,4,5],[2,4,2,2],[2,4,2,2]]
// Output: 3
// Explanation: There are 3 equal row and column pairs:
// - (Row 0, Column 0): [3,1,2,2]
// - (Row 2, Column 2): [2,4,2,2]
// - (Row 3, Column 2): [2,4,2,2]

// Constraints:
//     n == grid.length == grid[i].length
//     1 <= n <= 200
//     1 <= grid[i][j] <= 105

import 'testable.dart';

class Solution {
  int equalPairs(List<List<int>> grid) {
    var equalsCount = 0;

    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid.length; j++) {
        var isEqual = true;

        for (var a = 0; a < grid.first.length; a++) {
          if (grid[i][a] != grid[a][j]) {
            isEqual = false;
            break;
          }
        }
        if (isEqual) equalsCount++;
      }
    }

    return equalsCount;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.grid, required super.result});

  List<List<int>> grid;

  @override
  int computeResult() => Solution().equalPairs(grid);
}

void main(List<String> args) {
  [
    SolutionTest(
      grid: [
        [3, 2, 1],
        [1, 7, 6],
        [2, 7, 7],
      ],
      result: 1,
    ),
    SolutionTest(
      grid: [
        [3, 1, 2, 2],
        [1, 4, 4, 5],
        [2, 4, 2, 2],
        [2, 4, 2, 2],
      ],
      result: 3,
    ),
    SolutionTest(
      grid: [
        [18, 18, 18, 18, 18],
        [18, 18, 18, 18, 17],
        [18, 18, 18, 18, 18],
        [18, 18, 18, 18, 18],
        [18, 18, 18, 18, 18],
      ],
      result: 16,
    ),
  ].test();
}
