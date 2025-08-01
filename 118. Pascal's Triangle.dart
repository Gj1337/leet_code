// Given an integer numRows,
// return the first numRows of Pascal's triangle.
// In Pascal's triangle, each number is the sum of the two numbers
// directly above it as shown:

// Example 1:
// Input: numRows = 5
// Output: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]

// Example 2:
// Input: numRows = 1
// Output: [[1]]

// Constraints:
//     1 <= numRows <= 30

import 'testable.dart';

class Solution {
  List<List<int>> generate(int numRows) {
    final result = List.generate(numRows, (index) => List.filled(index + 1, 1));

    for (var i = 2; i < numRows; i++) {
      for (var j = 1; j < result[i].length - 1; j++) {
        result[i][j] = result[i - 1][j - 1] + result[i - 1][j];
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  SolutionTest({required this.numRows, required super.result});

  final int numRows;

  @override
  List<List<int>> computeResult() => Solution().generate(numRows);
}

void main(List<String> args) {
  [
    SolutionTest(
      numRows: 5,
      result: [
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
      ],
    ),
  ].test();
}
