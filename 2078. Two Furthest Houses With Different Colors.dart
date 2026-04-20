// There are n houses evenly lined up on the street, and each house is beautifully painted. You are given a 0-indexed integer array colors of length n, where colors[i] represents the color of the ith house.
// Return the maximum distance between two houses with different colors.
// The distance between the ith and jth houses is abs(i - j), where abs(x) is the absolute value of x.

// Example 1:
// Input: colors = [1,1,1,6,1,1,1]
// Output: 3
// Explanation: In the above image, color 1 is blue, and color 6 is red.
// The furthest two houses with different colors are house 0 and house 3.
// House 0 has color 1, and house 3 has color 6. The distance between them is abs(0 - 3) = 3.
// Note that houses 3 and 6 can also produce the optimal answer.

// Example 2:
// Input: colors = [1,8,3,8,3]
// Output: 4
// Explanation: In the above image, color 1 is blue, color 8 is yellow, and color 3 is green.
// The furthest two houses with different colors are house 0 and house 4.
// House 0 has color 1, and house 4 has color 3. The distance between them is abs(0 - 4) = 4.

// Example 3:
// Input: colors = [0,1]
// Output: 1
// Explanation: The furthest two houses with different colors are house 0 and house 1.
// House 0 has color 0, and house 1 has color 1. The distance between them is abs(0 - 1) = 1.

// Constraints:
// n == colors.length
// 2 <= n <= 100
// 0 <= colors[i] <= 100
// Test data are generated such that at least two houses have different colors.

import 'testable.dart';

class Solution {
  int maxDistance(List<int> colors) {
    var leftPointer = 0;
    var rightPointer = colors.length - 1;

    var leftDistance = 0;

    while (leftPointer < rightPointer) {
      if (colors[leftPointer] != colors[rightPointer]) {
        leftDistance = rightPointer - leftPointer;

        break;
      }

      rightPointer--;
    }

    if (leftDistance == 0) return leftDistance;

    leftPointer = 0;
    rightPointer = colors.length - 1;

    var rightDistance = 0;

    while (leftPointer < rightPointer) {
      final distance = rightPointer - leftPointer;

      if (distance < leftDistance) return leftDistance;
      if (colors[leftPointer] != colors[rightPointer]) {
        rightDistance = distance;

        break;
      }

      leftPointer++;
    }

    return leftDistance > rightDistance ? leftDistance : rightDistance;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> colors;

  SolutionTest({required this.colors, required super.result});

  @override
  int computeResult() => Solution().maxDistance(colors);
}

void main(List<String> args) {
  [
    // Example 1: Different color in the middle
    SolutionTest(colors: [1, 1, 1, 6, 1, 1, 1], result: 3),

    // Example 2: Different colors at the extreme ends
    SolutionTest(colors: [1, 8, 3, 8, 3], result: 4),

    // Example 3: Minimal length array
    SolutionTest(colors: [0, 1], result: 1),

    // Variant 4: Multiple different colors, furthest is second to last
    // Distance between index 0 (color 4) and index 4 (color 3)
    SolutionTest(colors: [4, 4, 4, 4, 3, 4], result: 4),

    // Variant 5: Only the first house is different
    // Distance between index 0 (color 10) and index 5 (color 5)
    SolutionTest(colors: [10, 5, 5, 5, 5, 5], result: 5),

    // Variant 6: Only the last house is different
    SolutionTest(colors: [7, 7, 7, 7, 7, 12], result: 5),

    // Variant 7: All houses are different colors
    // Distance between index 0 and index 4
    SolutionTest(colors: [1, 2, 3, 4, 5], result: 4),

    // Variant 8: Large gap with identical colors in between
    SolutionTest(colors: [1, 0, 0, 0, 0, 0, 0, 2], result: 7),
  ].test();
}
