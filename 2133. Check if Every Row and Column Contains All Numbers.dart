// An n x n matrix is valid if every row and every column contains
// all the integers from 1 to n (inclusive).
// Given an n x n integer matrix matrix, return true if the matrix is valid.
// Otherwise, return false.

// Example 1:
// Input: matrix = [[1,2,3],[3,1,2],[2,3,1]]
// Output: true
// Explanation: In this case, n = 3,
// and every row and column contains the numbers 1, 2, and 3.
// Hence, we return true.

// Example 2:
// Input: matrix = [[1,1,1],[1,2,3],[1,2,3]]
// Output: false
// Explanation: In this case, n = 3,
// but the first row and the first column do not contain the numbers 2 or 3.
// Hence, we return false.

// Constraints:
//     n == matrix.length == matrix[i].length
//     1 <= n <= 100
//     1 <= matrix[i][j] <= n

import 'testable.dart';

class Solution {
  bool checkValid(List<List<int>> matrix) {
    final numbers = List.generate(matrix.length, (index) => index + 1).toSet();

    for (var i = 0; i < matrix.length; i++) {
      var checkSet = Set.from(numbers);
      for (var j = 0; j < matrix.first.length; j++) {
        checkSet.remove(matrix[i][j]);
      }
      if (checkSet.isNotEmpty) return false;
    }

    for (var j = 0; j < matrix.first.length; j++) {
      var checkSet = Set.from(numbers);
      for (var i = 0; i < matrix.length; i++) {
        checkSet.remove(matrix[i][j]);
      }
      if (checkSet.isNotEmpty) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<List<int>> matrix;

  SolutionTest({required this.matrix, required super.result});

  @override
  bool computeResult() => Solution().checkValid(matrix);
}

void main(List<String> args) {
  [
    SolutionTest(
      matrix: [
        [1, 2, 3],
        [3, 1, 2],
        [2, 3, 1],
      ],
      result: true,
    ),
    SolutionTest(
      matrix: [
        [1, 1, 1],
        [3, 1, 2],
        [2, 3, 1],
      ],
      result: false,
    ),
    SolutionTest(
      matrix: [
        [1, 2, 3],
        [3, 1, 2],
        [1, 2, 3],
      ],
      result: false,
    ),
  ].test();
}
