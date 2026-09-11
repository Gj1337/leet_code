// Given an integer array nums of length n where all the integers of nums are in the range [1, n]
// and each integer appears at most twice, return an array of all the integers that appears twice.
// You must write an algorithm that runs in O(n) time and uses only constant auxiliary space,
// excluding the space needed to store the output
//
// Example 1:
// Input: nums = [4,3,2,7,8,2,3,1]
// Output: [2,3]
//
// Example 2:
// Input: nums = [1,1,2]
// Output: [1]
//
// Example 3:
// Input: nums = [1]
// Output: []
//
// Constraints:
// n == nums.length
// 1 <= n <= 105
// 1 <= nums[i] <= n
// Each element in nums appears once or twice.

import 'testable.dart';

class Solution {
  List<int> findDuplicates(List<int> nums) {
    final result = <int>[];

    nums.forEach((number) {
      final value = number.abs(), index = value - 1;
      nums[index] > 0 ? nums[index] = -nums[index] : result.add(value);
    });

    return result;
  }
}

// Solution using hashmap, not constant auxiliary space
//
// class Solution {
//   List<int> findDuplicates(List<int> nums) {
//     final cache = <int, int>{};
//     final result = <int>[];
//
//     for (final number in nums) {
//       cache[number] = (cache[number] ?? 0) + 1;
//     }
//
//     cache.forEach((key, value) {
//       if (value == 2) result.add(key);
//     });
//
//     return result;
//   }
// }

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  bool validateResult(List<int> computedResult, List<int> expectedResult) {
    for (var computedValue in computedResult) {
      if (!expectedResult.contains(computedValue)) return false;
    }

    return true;
  }

  @override
  List<int> computeResult() => Solution().findDuplicates(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [4, 3, 2, 7, 8, 2, 3, 1], result: [2, 3]),
    SolutionTest(nums: [1, 1, 2], result: [1]),
  ].test();
}
