// Given an integer array nums and an integer k,
// return true if there are two distinct indices
// i and j in the array such that nums[i] == nums[j]
// and abs(i - j) <= k.

// Example 1:
// Input: nums = [1,2,3,1], k = 3
// Output: true

// Example 2:
// Input: nums = [1,0,1,1], k = 1
// Output: true

// Example 3:
// Input: nums = [1,2,3,1,2,3], k = 2
// Output: false

// Constraints:
//     1 <= nums.length <= 105
//     -109 <= nums[i] <= 109
//     0 <= k <= 105

import 'testable.dart';

class Solution {
  bool containsNearbyDuplicate(List<int> nums, int k) {
    final positionMap = <int, int>{};

    for (var i = 0; i < nums.length; i++) {
      if (positionMap.containsKey(nums[i])) {
        final oldPosition = positionMap[nums[i]]!;
        final currentPosition = i;

        if ((oldPosition - currentPosition).abs() <= k) {
          return true;
        }
      }

      positionMap[nums[i]] = i;
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<int> nums;
  final int k;

  SolutionTest({required this.nums, required this.k, required super.result});

  @override
  bool computeResult() => Solution().containsNearbyDuplicate(nums, k);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [1, 2, 3, 1], k: 3, result: true),
    SolutionTest(nums: [1, 0, 1, 1], k: 1, result: true),
    SolutionTest(nums: [1, 2, 3, 1, 2, 3], k: 2, result: false)
  ].test();
}
