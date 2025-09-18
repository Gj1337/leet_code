// Given an integer array nums of unique elements,
// return all possible subsets(the power set).
// The solution set must not contain duplicate subsets.
// Return the solution in any order.

// Example 1:
// Input: nums = [1,2,3]
// Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]

// Example 2:
// Input: nums = [0]
// Output: [[],[0]]

// Constraints:
//     1 <= nums.length <= 10
//     -10 <= nums[i] <= 10
//     All the numbers of nums are unique.
import 'testable.dart';

class Solution {
  List<List<int>> subsets(List<int> nums) {
    final result = <List<int>>[[]];

    for (final num in nums) {
      final newSubsets = <List<int>>[];
      for (final currentSubset in result) {
        newSubsets.add([...currentSubset, num]);
      }
      result.addAll(newSubsets);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  List<List<int>> computeResult() => Solution().subsets(nums);

  @override
  bool test() {
    final computedResult = computeResult();

    if (computedResult.length != result.length) return false;
    for (var combination in computedResult) {
      if (!result.contains(combination)) return false;
    }

    return true;
  }
}

void main() {
  [
    SolutionTest(
      nums: [1, 2, 3],
      result: [
        [],
        [1],
        [2],
        [1, 2],
        [3],
        [1, 3],
        [2, 3],
        [1, 2, 3]
      ],
    ),
    SolutionTest(
      nums: [0],
      result: [
        [],
        [0],
      ],
    ),
  ].test();
}
