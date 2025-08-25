// Given an m x n matrix, return all elements of the matrix in spiral order.

// Example 1:
// Input: matrix = [[1,2,3],
//                  [4,5,6],
//                  [7,8,9]]
// Output: [1,2,3,6,9,8,7,4,5]

// Example 2:
// Input: matrix = [[1,2,3,4],
//                  [5,6,7,8],
//                  [9,10,11,12]]
// Output: [1,2,3,4,8,12,11,10,9,5,6,7]

// Constraints:
//     m == matrix.length
//     n == matrix[i].length
//     1 <= m, n <= 10
//     -100 <= matrix[i][j] <= 100

import 'testable.dart';

class Solution {
  List<int> spiralOrder(List<List<int>> matrix) {
    final result = List.filled(matrix.length * matrix.first.length, 0);

    var (i, j) = (0, 0);
    var (iStep, jStep) = (0, 1);

    var top = -1;
    var bottom = matrix.length;
    var left = -1;
    var right = matrix.first.length;

    var counter = 0;

    while (counter < result.length) {
      result[counter] = matrix[i][j];
      counter++;

      final (nextI, nextJ) = (i + iStep, j + jStep);

      if (nextJ == right) {
        (iStep, jStep) = (1, 0);
        top += 1;
      } else if (nextI == bottom) {
        (iStep, jStep) = (0, -1);
        right -= 1;
      } else if (nextJ == left) {
        (iStep, jStep) = (-1, 0);
        bottom -= 1;
      } else if (nextI == top) {
        (iStep, jStep) = (0, 1);
        left += 1;
      }

      (i, j) = (i + iStep, j + jStep);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<List<int>> matrix;

  SolutionTest({required this.matrix, required super.result});

  @override
  List<int> computeResult() => Solution().spiralOrder(matrix);
}

void main(List<String> args) {
  [
    SolutionTest(
      matrix: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ],
      result: [1, 2, 3, 6, 9, 8, 7, 4, 5],
    ),
    SolutionTest(
      matrix: [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12]
      ],
      result: [1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7],
    ),
    SolutionTest(
      matrix: [
        [1, 2, 3, 4],
      ],
      result: [1, 2, 3, 4],
    ),
    SolutionTest(
      matrix: [
        [1],
        [2],
        [3],
        [4],
      ],
      result: [1, 2, 3, 4],
    ),
  ].test();
}
