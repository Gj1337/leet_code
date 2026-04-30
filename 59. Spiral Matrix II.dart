// Given a positive integer n, generate an n x n matrix filled with elements from 1 to n2 in spiral order.

// Example 1:
// Input: n = 3
// Output: [[1,2,3],[8,9,4],[7,6,5]]

// Example 2:
// Input: n = 1
// Output: [[1]]

// Constraints:
// 1 <= n <= 20

import 'testable.dart';

class Solution {
  List<List<int>> generateMatrix(var n) {
    final matrix = List.generate(n, (_) => List.filled(n, 0));

    var top = 0;
    var bottom = n - 1;
    var left = 0;
    var right = n - 1;

    var num = 1;

    while (top <= bottom && left <= right) {
      for (var j = left; j <= right; j++) {
        matrix[top][j] = num++;
      }
      top++;

      for (var i = top; i <= bottom; i++) {
        matrix[i][right] = num++;
      }
      right--;

      if (top <= bottom) {
        for (var j = right; j >= left; j--) {
          matrix[bottom][j] = num++;
        }
        bottom--;
      }

      if (left <= right) {
        for (var i = bottom; i >= top; i--) {
          matrix[i][left] = num++;
        }
        left++;
      }
    }

    return matrix;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  List<List<int>> computeResult() => Solution().generateMatrix(n);
}

void main(List<String> args) {
  [
    SolutionTest(
      n: 3,
      result: [
        [1, 2, 3],
        [8, 9, 4],
        [7, 6, 5],
      ],
    ),
  ].test();
}
