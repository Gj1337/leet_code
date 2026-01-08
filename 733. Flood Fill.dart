// You are given an image represented by an m x n grid of integers image, where image[i][j] represents the pixel value of the image. You are also given three integers sr, sc, and color. Your task is to perform a flood fill on the image starting from the pixel image[sr][sc].
// To perform a flood fill:
// Begin with the starting pixel and change its color to color.
// Perform the same process for each pixel that is directly adjacent (pixels that share a side with the original pixel, either horizontally or vertically) and shares the same color as the starting pixel.
// Keep repeating this process by checking neighboring pixels of the updated pixels and modifying their color if it matches the original color of the starting pixel.
// The process stops when there are no more adjacent pixels of the original color to update.
// Return the modified image after performing the flood fill.
//
// Example 1:
// Input: image = [[1,1,1],[1,1,0],[1,0,1]], sr = 1, sc = 1, color = 2
// Output: [[2,2,2],[2,2,0],[2,0,1]]
// Explanation:
// From the center of the image with position (sr, sc) = (1, 1) (i.e., the red pixel), all pixels connected by a path of the same color as the starting pixel (i.e., the blue pixels) are colored with the new color.
// Note the bottom corner is not colored 2, because it is not horizontally or vertically connected to the starting pixel.
//
// Example 2:
// Input: image = [[0,0,0],[0,0,0]], sr = 0, sc = 0, color = 0
// Output: [[0,0,0],[0,0,0]]
// Explanation:
// The starting pixel is already colored with 0, which is the same as the target color. Therefore, no changes are made to the image.
//
// Constraints:
// m == image.length
// n == image[i].length
// 1 <= m, n <= 50
// 0 <= image[i][j], color < 216
// 0 <= sr < m
// 0 <= sc < n

import 'testable.dart';

class Solution {
  List<List<int>> floodFill(List<List<int>> image, int sr, int sc, int color) {
    final initialColor = image[sr][sc];

    if (initialColor == color) return image;

    image[sr][sc] = color;
    //it doesn't important in this task
    //whether we use Queue or Stack
    //the order isn't matter.
    final stack = <(int i, int j)>[(sr, sc)];

    while (stack.isNotEmpty) {
      final (i, j) = stack.removeLast();

      if (i > 0 && image[i - 1][j] == initialColor) {
        image[i - 1][j] = color;
        stack.add((i - 1, j));
      }
      if (i < image.length - 1 && image[i + 1][j] == initialColor) {
        image[i + 1][j] = color;
        stack.add((i + 1, j));
      }
      if (j > 0 && image[i][j - 1] == initialColor) {
        image[i][j - 1] = color;
        stack.add((i, j - 1));
      }
      if (j < image[i].length - 1 && image[i][j + 1] == initialColor) {
        image[i][j + 1] = color;
        stack.add((i, j + 1));
      }
    }

    return image;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<List<int>> image;
  final int sr;
  final int sc;
  final int color;

  SolutionTest({
    required this.image,
    required this.sr,
    required this.sc,
    required this.color,
    required super.result,
  });

  @override
  List<List<int>> computeResult() => Solution().floodFill(image, sr, sc, color);
}

void main(List<String> args) {
  [
    SolutionTest(
      image: [
        [1, 1, 1],
        [1, 1, 0],
        [1, 0, 1],
      ],
      sr: 1,
      sc: 1,
      color: 2,
      result: [
        [2, 2, 2],
        [2, 2, 0],
        [2, 0, 1],
      ],
    ),
    SolutionTest(
      image: [
        [0, 0, 0],
        [0, 0, 0],
      ],
      sr: 0,
      sc: 0,
      color: 0,
      result: [
        [0, 0, 0],
        [0, 0, 0],
      ],
    ),
  ].test();
}
