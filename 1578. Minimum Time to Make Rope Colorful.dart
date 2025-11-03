// Alice has n balloons arranged on a rope. You are given a 0-indexed string colors where colors[i] is the color of the ith balloon.
//
// Alice wants the rope to be colorful. She does not want two consecutive balloons to be of the same color, so she asks Bob for help. Bob can remove some balloons from the rope to make it colorful. You are given a 0-indexed integer array neededTime where neededTime[i] is the time (in seconds) that Bob needs to remove the ith balloon from the rope.
//
// Return the minimum time Bob needs to make the rope colorful.
//
// Example 1:
// Input: colors = "abaac", neededTime = [1,2,3,4,5]
// Output: 3
// Explanation: In the above image, 'a' is blue, 'b' is red, and 'c' is green.
// Bob can remove the blue balloon at index 2. This takes 3 seconds.
// There are no longer two consecutive balloons of the same color. Total time = 3.
//
// Example 2:
// Input: colors = "abc", neededTime = [1,2,3]
// Output: 0
// Explanation: The rope is already colorful. Bob does not need to remove any balloons from the rope.
//
// Example 3:
// Input: colors = "aabaa", neededTime = [1,2,3,4,1]
// Output: 2
// Explanation: Bob will remove the balloons at indices 0 and 4. Each balloons takes 1 second to remove.
// There are no longer two consecutive balloons of the same color. Total time = 1 + 1 = 2.
//
// Constraints:
// n == colors.length == neededTime.length
// 1 <= n <= 105
// 1 <= neededTime[i] <= 104
// colors contains only lowercase English letters.

import 'testable.dart';

class Solution {
  int minCost(String colors, List<int> neededTime) {
    var result = 0;
    var currentSum = neededTime.first;
    var currentMax = neededTime.first;

    for (var i = 1; i < colors.length; i++) {
      if (colors[i - 1] != colors[i]) {
        if (currentSum != neededTime[i - 1]) {
          result += (currentSum - currentMax);
        }

        currentSum = neededTime[i];
        currentMax = neededTime[i];
      } else {
        currentMax = neededTime[i] > currentMax ? neededTime[i] : currentMax;
        currentSum += neededTime[i];
      }
    }

    if (currentSum != neededTime.last) {
      result += (currentSum - currentMax);
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String colors;
  final List<int> neededTime;

  SolutionTest({
    required this.colors,
    required this.neededTime,
    required super.result,
  });

  @override
  int computeResult() => Solution().minCost(colors, neededTime);
}

void main(List<String> args) {
  [
    SolutionTest(colors: "abaac", neededTime: [1, 2, 3, 4, 5], result: 3),
    SolutionTest(colors: "abc", neededTime: [1, 2, 3], result: 0),
    SolutionTest(colors: "aabaa", neededTime: [1, 2, 3, 4, 1], result: 2)
  ].test();
}
