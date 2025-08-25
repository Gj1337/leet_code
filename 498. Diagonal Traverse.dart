// Given an m x n matrix mat,
// return an array of all the elements of the array in a diagonal order.

// Example 1:
// Input: mat = [[1,2,3],
//               [4,5,6],
//               [7,8,9]]
// Output: [1,2,4,7,5,3,6,8,9]

// Example 2:
// Input: mat = [[1,2],
//               [3,4]]
// Output: [1,2,3,4]

// Constraints:
//     m == mat.length
//     n == mat[i].length
//     1 <= m, n <= 104
//     1 <= m * n <= 104
//     -105 <= mat[i][j] <= 105

import 'testable.dart';

class Solution {
  List<int> findDiagonalOrder(List<List<int>> mat) {
    final result = List.filled(mat.length * mat.first.length, 0);

    var i = 0, j = 0;
    var iStep = -1, jStep = 1;

    var counter = 0;

    while (counter < result.length) {
      result[counter] = mat[i][j];
      counter++;

      i += iStep;
      j += jStep;

      final touchTop = i < 0 && j < mat.first.length;
      final touchRight = j > mat.first.length - 1;
      final touchLeft = j < 0 && i < mat.length;
      final touchBottom = i > mat.length - 1;

      if (touchTop || touchRight || touchLeft || touchBottom) {
        iStep = -iStep;
        jStep = -jStep;
      }

      if (touchTop) {
        i += iStep;
      }
      if (touchLeft) {
        j += jStep;
      }
      if (touchRight) {
        i += 2 * iStep;
        j += jStep;
      }
      if (touchBottom) {
        j += 2 * jStep;
        i += iStep;
      }
    }
    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<List<int>> mat;

  SolutionTest({required this.mat, required super.result});

  @override
  List<int> computeResult() => Solution().findDiagonalOrder(mat);
}

void main(List<String> args) {
  [
    SolutionTest(
      mat: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ],
      result: [1, 2, 4, 7, 5, 3, 6, 8, 9],
    ),
    SolutionTest(
      mat: [
        [1, 2],
        [3, 4]
      ],
      result: [1, 2, 3, 4],
    ),
    SolutionTest(
      mat: [
        [1, 2, 3, 4]
      ],
      result: [1, 2, 3, 4],
    ),
    SolutionTest(
      mat: [
        [1],
        [2],
        [3],
        [4],
      ],
      result: [1, 2, 3, 4],
    )
  ].test();
}
