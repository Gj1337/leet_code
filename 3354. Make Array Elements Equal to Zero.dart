// You are given an integer array nums.
// Start by selecting a starting position curr such that nums[curr] == 0, and choose a movement direction of either left or right.
// After that, you repeat the following process:
// If curr is out of the range [0, n - 1], this process ends.
// If nums[curr] == 0, move in the current direction by incrementing curr if you are moving right, or decrementing curr if you are moving left.
// Else if nums[curr] > 0:
// Decrement nums[curr] by 1.
// Reverse your movement direction (left becomes right and vice versa).
// Take a step in your new direction.
// A selection of the initial position curr and movement direction is considered valid if every element in nums becomes 0 by the end of the process.
//
// Return the number of possible valid selections.
//
// Example 1:
// Input: nums = [1,0,2,0,3]
// Output: 2
// Explanation:
// The only possible valid selections are the following:
//
// Choose curr = 3, and a movement direction to the left.
// [1,0,2,0,3] -> [1,0,2,0,3] -> [1,0,1,0,3] -> [1,0,1,0,3] -> [1,0,1,0,2] -> [1,0,1,0,2] -> [1,0,0,0,2] -> [1,0,0,0,2] -> [1,0,0,0,1] -> [1,0,0,0,1] -> [1,0,0,0,1] -> [1,0,0,0,1] -> [0,0,0,0,1] -> [0,0,0,0,1] -> [0,0,0,0,1] -> [0,0,0,0,1] -> [0,0,0,0,0].
// Choose curr = 3, and a movement direction to the right.
// [1,0,2,0,3] -> [1,0,2,0,3] -> [1,0,2,0,2] -> [1,0,2,0,2] -> [1,0,1,0,2] -> [1,0,1,0,2] -> [1,0,1,0,1] -> [1,0,1,0,1] -> [1,0,0,0,1] -> [1,0,0,0,1] -> [1,0,0,0,0] -> [1,0,0,0,0] -> [1,0,0,0,0] -> [1,0,0,0,0] -> [0,0,0,0,0].
//
// Example 2:
// Input: nums = [2,3,4,0,4,1,0]
// Output: 0
// Explanation:
// There are no possible valid selections.
//
// Constraints:
//
// 1 <= nums.length <= 100
// 0 <= nums[i] <= 100
// There is at least one element i where nums[i] == 0.

import 'testable.dart';

class Solution {
  int countValidSelections(List<int> nums) {
    List<int> bounce(
        {required List<int> nums, int position = 0, bool moveRight = true}) {
      position = moveRight ? position + 1 : position - 1;

      while (position >= 0 && position < nums.length) {
        if (nums[position] != 0) {
          nums[position]--;
          moveRight = !moveRight;
        }

        position = moveRight ? position + 1 : position - 1;
      }

      return nums;
    }

    var result = 0;

    for (var i = 0; i < nums.length; i++) {
      if (nums[i] != 0) continue;

      final moveLeft =
          bounce(nums: List.of(nums), position: i, moveRight: false);
      final moveRight =
          bounce(nums: List.of(nums), position: i, moveRight: true);

      if ((moveLeft.firstWhere((element) => element != 0, orElse: () => -1)) ==
          -1) {
        result++;
      }
      if ((moveRight.firstWhere((element) => element != 0, orElse: () => -1)) ==
          -1) {
        result++;
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().countValidSelections(nums);
}

main() {
  [
    SolutionTest(nums: [1, 0, 2, 0, 3], result: 2),
    SolutionTest(nums: [2, 3, 4, 0, 4, 1, 0], result: 0),
  ].test();
}
