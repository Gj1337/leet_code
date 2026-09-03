// Given an n x n binary matrix image, flip the image horizontally, then invert it, and return the resulting image.
// To flip an image horizontally means that each row of the image is reversed.
// For example, flipping [1,1,0] horizontally results in [0,1,1].
// To invert an image means that each 0 is replaced by 1, and each 1 is replaced by 0.
// For example, inverting [0,1,1] results in [1,0,0].
//
// Example 1:
// Input: image = [[1,1,0],[1,0,1],[0,0,0]]
// Output: [[1,0,0],[0,1,0],[1,1,1]]
// Explanation: First reverse each row: [[0,1,1],[1,0,1],[0,0,0]].
// Then, invert the image: [[1,0,0],[0,1,0],[1,1,1]]
//
// Example 2:
// Input: image = [[1,1,0,0],[1,0,0,1],[0,1,1,1],[1,0,1,0]]
// Output: [[1,1,0,0],[0,1,1,0],[0,0,0,1],[1,0,1,0]]
// Explanation: First reverse each row: [[0,0,1,1],[1,0,0,1],[1,1,1,0],[0,1,0,1]].
// Then invert the image: [[1,1,0,0],[0,1,1,0],[0,0,0,1],[1,0,1,0]]
//
// Constraints:
// n == image.length
// n == image[i].length
// 1 <= n <= 20
// images[i][j] is either 0 or 1.

import 'testable.dart';

class Solution {
  List<List<int>> flipAndInvertImage(List<List<int>> image) {
    final height = image.length;
    final width = image.first.length;

    for (var i = 0; i < height; i++) {
      for (var j = 0; j < (width + 1) ~/ 2; j++) {
        final oppositeJ = image.length - j - 1;

        final buff = image[i][j];
        image[i][j] = 1 - image[i][oppositeJ];
        image[i][oppositeJ] = 1 - buff;
      }
    }

    return image;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<List<int>> image;

  SolutionTest({required this.image, required super.result});

  @override
  List<List<int>> computeResult() => Solution().flipAndInvertImage(image);
}

void main(List<String> args) {
  [
    SolutionTest(
      image: [
        [1, 1, 0],
        [1, 0, 1],
        [0, 0, 0],
      ],
      result: [
        [1, 0, 0],
        [0, 1, 0],
        [1, 1, 1],
      ],
    ),
    SolutionTest(
      image: [
        [1, 1, 0, 0],
        [1, 0, 0, 1],
        [0, 1, 1, 1],
        [1, 0, 1, 0],
      ],
      result: [
        [1, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 1],
        [1, 0, 1, 0],
      ],
    ),
  ].test();
}
