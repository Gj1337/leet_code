// You are given an integer array height of length n.
// There are n vertical lines drawn such that
// the two endpoints of the ith line are (i, 0) and (i, height[i]).
// Find two lines that together with the x-axis form a container,
// such that the container contains the most water.
// Return the maximum amount of water a container can store.
// Notice that you may not slant the container.

// Example 1:
// Input: height = [1,8,6,2,5,4,8,3,7]
// Output: 49
// Explanation: The above vertical lines are represented
// by array [1,8,6,2,5,4,8,3,7].
// In this case, the max area of water (blue section)
// the container can contain is 49.

// Example 2:
// Input: height = [1,1]
// Output: 1

// Constraints:
//     n == height.length
//     2 <= n <= 105
//     0 <= height[i] <= 104

import 'testable.dart';

class Solution {
  int maxArea(List<int> height) {
    if (height.length < 2) return 0;

    var first = 0;
    var second = height.length - 1;
    var biggestArea =
        (height[first] < height[second] ? height[first] : height[second]) *
        (first - second).abs();

    while (first != second) {
      if (height[first] < height[second]) {
        first++;
      } else {
        second--;
      }

      final currentArea =
          (height[first] < height[second] ? height[first] : height[second]) *
          (first - second).abs();

      biggestArea = biggestArea > currentArea ? biggestArea : currentArea;
    }

    return biggestArea;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.height, required super.result});

  final List<int> height;

  @override
  String? get name => '$height';

  @override
  int computeResult() => Solution().maxArea(height);
}

void main(List<String> args) {
  [
    SolutionTest(height: [1, 8, 6, 2, 5, 4, 8, 3, 7], result: 49),
    SolutionTest(height: [1, 1], result: 1),
    SolutionTest(height: [1, 3, 2, 5, 25, 24, 5], result: 24),
  ].test();
}
