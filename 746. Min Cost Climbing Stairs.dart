// You are given an integer array cost where cost[i] is the cost of ith step on a staircase.
// Once you pay the cost, you can either climb one or two steps.
// You can either start from the step with index 0, or the step with index 1.
// Return the minimum cost to reach the top of the staircase, which is the position just past the last step (index cost.length).
//
// Example 1:
// Input: cost = [10,15,20]
// Output: 15
// Explanation: You will start at index 1.
// - Pay 15 and climb two steps to reach the top.
// The total cost is 15.
//
// Example 2:
// Input: cost = [1,100,1,1,1,100,1,1,100,1]
// Output: 6
// Explanation: You will start at index 0.
// - Pay 1 and climb two steps to reach index 2.
// - Pay 1 and climb two steps to reach index 4.
// - Pay 1 and climb two steps to reach index 6.
// - Pay 1 and climb one step to reach index 7.
// - Pay 1 and climb two steps to reach index 9.
// - Pay 1 and climb one step to reach the top.
// The total cost is 6.
//
// Constraints:
// 2 <= cost.length <= 1000
// 0 <= cost[i] <= 999

import 'testable.dart';

class Solution {
  int minCostClimbingStairs(List<int> cost) {
    final bestCosts = List.filled(cost.length + 1, 0);

    for (var i = 2; i <= cost.length; i++) {
      final oneStepCost = bestCosts[i - 1] + cost[i - 1];
      final twoStepCost = bestCosts[i - 2] + cost[i - 2];

      bestCosts[i] = oneStepCost > twoStepCost ? twoStepCost : oneStepCost;
    }

    return bestCosts[cost.length];
  }
}

//Recursive solution get TLE
//
// class Solution {
//   int minCostClimbingStairs(List<int> cost) {
//     var result = -1;
//
//     void iterate(int nextIndex, int currentCost) {
//       currentCost += cost[nextIndex];
//       if (nextIndex >= cost.length - 2) {
//         if (result == -1 || result > currentCost) result = currentCost;
//         return;
//       }
//
//       iterate(nextIndex + 1, currentCost);
//       if (nextIndex + 2 < cost.length) iterate(nextIndex + 2, currentCost);
//     }
//
//     iterate(0, 0);
//     iterate(1, 0);
//
//     return result;
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> cost;

  SolutionTest({required this.cost, required super.result});

  @override
  int computeResult() => Solution().minCostClimbingStairs(cost);
}

void main() {
  [
    SolutionTest(cost: [10, 15, 20], result: 15),
    SolutionTest(cost: [1, 100, 1, 1, 1, 100, 1, 1, 100, 1], result: 6),
  ].test();
}
