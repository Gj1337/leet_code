// Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.
// The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.
// The test cases are generated such that the number of unique combinations that sum up to target is less than 150 combinations for the given input.
//
// Example 1:
// Input: candidates = [2,3,6,7], target = 7
// Output: [[2,2,3],[7]]
// Explanation:
// 2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
// 7 is a candidate, and 7 = 7.
// These are the only two combinations.
//
// Example 2:
// Input: candidates = [2,3,5], target = 8
// Output: [[2,2,2,2],[2,3,3],[3,5]]
//
// Example 3:
// Input: candidates = [2], target = 1
// Output: []
//
// Constraints:
// 1 <= candidates.length <= 30
// 2 <= candidates[i] <= 40
// All elements of candidates are distinct.
// 1 <= target <= 40

import 'testable.dart';

class Solution {
  List<List<int>> combinationSum(List<int> candidates, int target) {
    candidates.sort();
    final result = <List<int>>[];

    final currentSequence = <int>[];

    void backTrack(int currentSum, int startingIndex) {
      if (currentSum == target) {
        result.add([...currentSequence]);
        return;
      }
      final maxValue = target - currentSum;
      for (var i = startingIndex; i < candidates.length; i++) {
        final number = candidates[i];

        if (number <= maxValue) {
          currentSequence.add(number);
          backTrack(currentSum + number, i);
          currentSequence.removeLast();
        } else {
          break;
        }
      }
    }

    backTrack(0, 0);

    return result;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<int> candidates;
  final int target;

  SolutionTest({
    required this.candidates,
    required this.target,
    required super.result,
  });

  @override
  List<List<int>> computeResult() =>
      Solution().combinationSum(candidates, target);
}

void main(List<String> args) {
  [
    SolutionTest(
      candidates: [2, 3, 6, 7],
      target: 7,
      result: [
        [2, 2, 3],
        [7],
      ],
    ),
    SolutionTest(
      candidates: [2, 3, 5],
      target: 8,
      result: [
        [2, 2, 2, 2],
        [2, 3, 3],
        [3, 5],
      ],
    ),
    SolutionTest(candidates: [2], target: 1, result: []),
  ].test();
}
