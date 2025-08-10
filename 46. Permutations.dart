// Given an array nums of distinct integers, return all the possible.
// You can return the answer in any order.

// Example 1:
// Input: nums = [1,2,3]
// Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

// Example 2:
// Input: nums = [0,1]
// Output: [[0,1],[1,0]]

// Example 3:
// Input: nums = [1]
// Output: [[1]]

// Constraints:
//     1 <= nums.length <= 6
//     -10 <= nums[i] <= 10

import 'testable.dart';

class Solution {
  List<List<int>> permute(List<int> nums) {
    final result = <List<int>>[];
    final checked = List.filled(nums.length, false);
    final current = <int>[];

    void backtrack() {
      if (current.length == nums.length) {
        result.add(List.from(current));
      }

      for (var i = 0; i < nums.length; i++) {
        if (!checked[i]) {
          checked[i] = true;
          current.add(nums[i]);

          backtrack();

          current.removeLast();
          checked[i] = false;
        }
      }
    }

    backtrack();
    return result;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  List<List<int>> computeResult() => Solution().permute(nums);
}

void main(List<String> args) {
  [
    SolutionTest(
      nums: [1, 2, 3],
      result: [
        [1, 2, 3],
        [1, 3, 2],
        [2, 1, 3],
        [2, 3, 1],
        [3, 1, 2],
        [3, 2, 1],
      ],
    ),

    SolutionTest(
      nums: [0, 1],
      result: [
        [0, 1],
        [1, 0],
      ],
    ),
  ].test();
}
