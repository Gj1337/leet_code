// You are given an n x n integer matrix. You can do the following operation any number of times:
//
// Choose any two adjacent elements of matrix and multiply each of them by -1.
// Two elements are considered adjacent if and only if they share a border.
//
// Your goal is to maximize the summation of the matrix's elements. Return the maximum sum of the matrix's elements using the operation mentioned above.
//
// Example 1:
// Input: matrix = [[1,-1],[-1,1]]
// Output: 4
// Explanation: We can follow the following steps to reach sum equals 4:
// - Multiply the 2 elements in the first row by -1.
// - Multiply the 2 elements in the first column by -1.
//
// Example 2:
// Input: matrix = [[1,2,3],[-1,-2,-3],[1,2,3]]
// Output: 16
// Explanation: We can follow the following step to reach sum equals 16:
// - Multiply the 2 last elements in the second row by -1.
//
// Constraints:
// n == matrix.length == matrix[i].length
// 2 <= n <= 250
// -105 <= matrix[i][j] <= 105

import 'testable.dart';

class Solution {
  int maxMatrixSum(List<List<int>> matrix) {
    var minimalAbs = matrix.first.first.abs();
    var negativeValueCount = 0;
    var sum = 0;

    for (final line in matrix) {
      for (final number in line) {
        final numberAbs = number.abs();
        sum += numberAbs;
        minimalAbs = minimalAbs > numberAbs ? numberAbs : minimalAbs;

        if (number < 0) negativeValueCount++;
      }
    }

    if (minimalAbs != 0 && negativeValueCount.isOdd) sum -= minimalAbs * 2;

    return sum;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> matrix;

  SolutionTest({required this.matrix, required super.result});

  @override
  int computeResult() => Solution().maxMatrixSum(matrix);
}

void main(List<String> args) {
  [
    SolutionTest(
      matrix: [
        [-3, 0, 0],
        [0, 0, 0],
        [0, 3, 2],
      ],
      result: 8,
    ),
    SolutionTest(
      matrix: [
        [2, 9, 3],
        [5, 4, -4],
        [1, 7, 1],
      ],
      result: 34,
    ),
    SolutionTest(
      matrix: [
        [-1, 0, -1],
        [-2, 1, 3],
        [3, 2, 2],
      ],
      result: 15,
    ),
    SolutionTest(
      matrix: [
        [1, -1],
        [-1, 1],
      ],
      result: 4,
    ),
    SolutionTest(
      matrix: [
        [1, 2, 3],
        [-1, -2, -3],
        [1, 2, 3],
      ],
      result: 16,
    ),
  ].test();
}
