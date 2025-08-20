// Given a m * n matrix of ones and zeros,
// return how many square submatrices have all ones.

// Example 1:
// Input: matrix =
// [
//   [0,1,1,1],
//   [1,1,1,1],
//   [0,1,1,1]
// ]
// Output: 15
// Explanation:
// There are 10 squares of side 1.
// There are 4 squares of side 2.
// There is  1 square of side 3.
// Total number of squares = 10 + 4 + 1 = 15.

// Example 2:
// Input: matrix =
// [
//   [1,0,1],
//   [1,1,0],
//   [1,1,0]
// ]
// Output: 7
// Explanation:
// There are 6 squares of side 1.
// There is 1 square of side 2.
// Total number of squares = 6 + 1 = 7.

// Constraints:
//     1 <= arr.length <= 300
//     1 <= arr[0].length <= 300
//     0 <= arr[i][j] <= 1

import 'testable.dart';

class Solution {
  int countSquares(List<List<int>> matrix) {
    var dpPrevious = List.filled(matrix.first.length, 0);
    var dpCurrent = List.filled(matrix.first.length, 0);
    var sum = 0;

    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == 0) continue;

        if (i == 0 || j == 0) {
          dpCurrent[j] = 1;
        } else {
          final left = dpCurrent[j - 1];
          final top = dpPrevious[j];
          final topLeft = dpPrevious[j - 1];

          dpCurrent[j] = min(left, min(topLeft, top)) + 1;
        }

        sum += dpCurrent[j];
      }

      final temp = dpPrevious;
      dpPrevious = dpCurrent;
      dpCurrent = temp..fillRange(0, dpCurrent.length, 0);
    }

    return sum;
  }

  int min(int a, int b) => a < b ? a : b;
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.matrix, required super.result});

  final List<List<int>> matrix;

  @override
  int computeResult() => Solution().countSquares(matrix);
}

void main(List<String> args) {
  [
    SolutionTest(
      matrix: [
        [0, 1, 1, 1],
        [1, 1, 1, 1],
        [0, 1, 1, 1]
      ],
      result: 15,
    ),
    SolutionTest(
      matrix: [
        [1, 0, 1],
        [1, 1, 0],
        [1, 1, 0]
      ],
      result: 7,
    )
  ].test();
}
