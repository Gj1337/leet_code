// We are given an array asteroids of integers representing asteroids in a row.
// The indices of the asteriod in the array represent
// their relative position in space.
// For each asteroid, the absolute value represents its size,
// and the sign represents its direction
//(positive meaning right, negative meaning left).
// Each asteroid moves at the same speed.
// Find out the state of the asteroids after all collisions.
// If two asteroids meet, the smaller one will explode.
// If both are the same size, both will explode.
// Two asteroids moving in the same direction will never meet.

// Example 1:
// Input: asteroids = [5,10,-5]
// Output: [5,10]
// Explanation: The 10 and -5 collide resulting in 10.
// The 5 and 10 never collide.

// Example 2:
// Input: asteroids = [8,-8]
// Output: []
// Explanation: The 8 and -8 collide exploding each other.

// Example 3:
// Input: asteroids = [10,2,-5]
// Output: [10]
// Explanation: The 2 and -5 collide resulting in -5.
// The 10 and -5 collide resulting in 10.

// Constraints:
//     2 <= asteroids.length <= 104
//     -1000 <= asteroids[i] <= 1000
//     asteroids[i] != 0

import 'testable.dart';

class Solution {
  List<int> asteroidCollision(List<int> asteroids) {
    final stack = <int>[];

    for (final asteroid in asteroids) {
      var destroyed = false;

      while (stack.isNotEmpty && stack.last > 0 && asteroid < 0) {
        if (stack.last < -asteroid) {
          stack.removeLast();
        } else if (stack.last == -asteroid) {
          stack.removeLast();
          destroyed = true;
          break;
        } else {
          destroyed = true;
          break;
        }
      }

      if (!destroyed) {
        stack.add(asteroid);
      }
    }

    return stack;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  SolutionTest({required this.asteroids, required super.result});

  final List<int> asteroids;

  @override
  List<int> computeResult() => Solution().asteroidCollision(asteroids);
}

void main(List<String> args) {
  [
    // Given examples
    SolutionTest(asteroids: [5, 10, -5], result: [5, 10]),
    SolutionTest(asteroids: [10, 2, -5], result: [10]),

    // Equal size collision, both destroyed
    SolutionTest(asteroids: [8, -8], result: []),

    // Multiple collisions
    SolutionTest(asteroids: [1, 3, 5, -2, -4, -6], result: [-6]),

    // No collisions (all same direction)
    SolutionTest(asteroids: [1, 2, 3], result: [1, 2, 3]),
    SolutionTest(asteroids: [-1, -2, -3], result: [-1, -2, -3]),

    // Large asteroid destroys many small ones
    SolutionTest(asteroids: [10, 5, 2, -8], result: [10]),

    // Left-moving asteroid survives after hitting smaller right-moving
    SolutionTest(asteroids: [2, -5], result: [-5]),

    // Chain reaction ending in survival
    SolutionTest(asteroids: [4, 3, -2, -5], result: [-5]),

    // Asteroids far apart in direction, no meeting
    SolutionTest(asteroids: [-2, 1, -1, 2], result: [-2, 2]),

    // Many collisions with equal sizes
    SolutionTest(asteroids: [3, -3, 4, -4, 5, -5], result: []),

    // Single asteroid survives after big battle
    SolutionTest(asteroids: [7, 8, -9], result: [-9]),
  ].test();
}
