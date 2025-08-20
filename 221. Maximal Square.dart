// Given an m x n binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.

// Example 1:
// Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
// Output: 4

// Example 2:
// Input: matrix = [["0","1"],["1","0"]]
// Output: 1

// Example 3:
// Input: matrix = [["0"]]
// Output: 0

// Constraints:
//     m == matrix.length
//     n == matrix[i].length
//     1 <= m, n <= 300
//     matrix[i][j] is '0' or '1'.

import 'testable.dart';

class Solution {
  int maximalSquare(List<List<String>> matrix) {
    var dpPrevious = List.filled(matrix.first.length, 0);
    var dpCurrent = List.filled(matrix.first.length, 0);
    var biggestSide = 0;

    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == '0') continue;

        if (i == 0 || j == 0) {
          dpCurrent[j] = 1;
        } else {
          final left = dpCurrent[j - 1];
          final top = dpPrevious[j];
          final topLeft = dpPrevious[j - 1];

          dpCurrent[j] = min(left, min(top, topLeft)) + 1;
        }

        biggestSide = dpCurrent[j] > biggestSide ? dpCurrent[j] : biggestSide;
      }

      final temp = dpPrevious;
      dpPrevious = dpCurrent;
      dpCurrent = temp..fillRange(0, dpCurrent.length, 0);
    }

    return biggestSide * biggestSide;
  }

  int min(int a, int b) => a < b ? a : b;
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.matrix, required super.result});

  final List<List<String>> matrix;

  @override
  int computeResult() => Solution().maximalSquare(matrix);
}

void main(List<String> args) {
  [
    SolutionTest(matrix: [
      ["1", "0", "1", "0", "0"],
      ["1", "0", "1", "1", "1"],
      ["1", "1", "1", "1", "1"],
      ["1", "0", "0", "1", "0"]
    ], result: 4),
    SolutionTest(matrix: [
      ["0", "1"],
      ["1", "0"]
    ], result: 1),
    SolutionTest(matrix: [
      ["0"]
    ], result: 0)
  ].test();
}
