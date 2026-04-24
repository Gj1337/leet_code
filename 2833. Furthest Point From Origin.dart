// You are given a string moves of length n consisting only of characters 'L', 'R', and '_'. The string represents your movement on a number line starting from the origin 0.
// In the ith move, you can choose one of the following directions:
// move to the left if moves[i] = 'L' or moves[i] = '_'
// move to the right if moves[i] = 'R' or moves[i] = '_'
// Return the distance from the origin of the furthest point you can get to after n moves.

// Example 1:
// Input: moves = "L_RL__R"
// Output: 3
// Explanation: The furthest point we can reach from the origin 0 is point -3 through the following sequence of moves "LLRLLLR".

// Example 2:
// Input: moves = "_R__LL_"
// Output: 5
// Explanation: The furthest point we can reach from the origin 0 is point -5 through the following sequence of moves "LRLLLLL".

// Example 3:
// Input: moves = "_______"
// Output: 7
// Explanation: The furthest point we can reach from the origin 0 is point 7 through the following sequence of moves "RRRRRRR".

// Constraints:
// 1 <= moves.length == n <= 50
// moves consists only of characters 'L', 'R' and '_'.

import 'testable.dart';

class Solution {
  int furthestDistanceFromOrigin(String moves) {
    var leftStepCount = 0;
    var rightStepCount = 0;
    var unknownStepCount = 0;

    for (var i = 0; i < moves.length; i++) {
      switch (moves[i]) {
        case 'R':
          rightStepCount++;
        case 'L':
          leftStepCount++;
        default:
          unknownStepCount++;
      }
    }

    return (leftStepCount - rightStepCount).abs() + unknownStepCount;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final String moves;

  SolutionTest({required this.moves, required super.result});

  @override
  int computeResult() => Solution().furthestDistanceFromOrigin(moves);
}

void main(List<String> args) {
  [
    // Original Examples
    SolutionTest(moves: "L_RL__R", result: 3),
    SolutionTest(moves: "_R__LL_", result: 5),
    SolutionTest(moves: "_______", result: 7),

    // Edge Case: All fixed directions (Same)
    SolutionTest(moves: "RRRRR", result: 5),

    // Edge Case: All fixed directions (Opposite)
    SolutionTest(moves: "LLLLL", result: 5),

    // Edge Case: Perfectly balanced fixed moves
    SolutionTest(moves: "RLRL__", result: 2),

    // Edge Case: Single character
    SolutionTest(moves: "L", result: 1),
    SolutionTest(moves: "R", result: 1),
    SolutionTest(moves: "_", result: 1),

    // Edge Case: Empty-ish or short mixed
    SolutionTest(moves: "R_", result: 2),
    SolutionTest(moves: "L_", result: 2),

    // Complex case: Net move is Right, underscores should become Right
    SolutionTest(
      moves: "RRLLR__",
      result: 3,
    ), // (3R - 2L) = 1 + 2 underscores = 3
    // Complex case: Net move is Left, underscores should become Left
    SolutionTest(
      moves: "LLRLR__",
      result: 3,
    ), // (3L - 2R) = 1 + 2 underscores = 3
  ].test();
}
