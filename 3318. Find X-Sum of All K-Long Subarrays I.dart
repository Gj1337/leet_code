// You are given an array nums of n integers and two integers k and x.
//
// The x-sum of an array is calculated by the following procedure:
//
// Count the occurrences of all elements in the array.
// Keep only the occurrences of the top x most frequent elements. If two elements have the same number of occurrences, the element with the bigger value is considered more frequent.
// Calculate the sum of the resulting array.
// Note that if an array has less than x distinct elements, its x-sum is the sum of the array.
//
// Return an integer array answer of length n - k + 1 where answer[i] is the x-sum of the subarray nums[i..i + k - 1].
//
// Example 1:
// Input: nums = [1,1,2,2,3,4,2,3], k = 6, x = 2
// Output: [6,10,12]
// Explanation:
// For subarray [1, 1, 2, 2, 3, 4], only elements 1 and 2 will be kept in the resulting array. Hence, answer[0] = 1 + 1 + 2 + 2.
// For subarray [1, 2, 2, 3, 4, 2], only elements 2 and 4 will be kept in the resulting array. Hence, answer[1] = 2 + 2 + 2 + 4. Note that 4 is kept in the array since it is bigger than 3 and 1 which occur the same number of times.
// For subarray [2, 2, 3, 4, 2, 3], only elements 2 and 3 are kept in the resulting array. Hence, answer[2] = 2 + 2 + 2 + 3 + 3.
//
// Example 2:
// Input: nums = [3,8,7,8,7,5], k = 2, x = 2
// Output: [11,15,15,15,12]
// Explanation:
// Since k == x, answer[i] is equal to the sum of the subarray nums[i..i + k - 1].
//
// Constraints:
// 1 <= n == nums.length <= 50
// 1 <= nums[i] <= 50
// 1 <= x <= k <= nums.length

import 'testable.dart';

class Solution {
  List<int> findXSum(List<int> nums, int k, int x) {
    final result = <int>[];
    final freq = <int, int>{};

    for (var i = 0; i < k && i < nums.length; i++) {
      freq[nums[i]] = (freq[nums[i]] ?? 0) + 1;
    }
    int _compareMapEntry(MapEntry<int, int> a, MapEntry<int, int> b) =>
        a.value != b.value
            ? b.value.compareTo(a.value)
            : b.key.compareTo(a.key);

    final freqEntities = freq.entries.toList()..sort(_compareMapEntry);
    final newValue = freqEntities
        .getRange(0, x > freqEntities.length ? freqEntities.length : x)
        .fold(0, (a, b) => a + b.key * b.value);
    result.add(newValue);

    var start = 0;
    var end = k + start;

    while (end < nums.length) {
      freq[nums[start]] = (freq[nums[start]] ?? 1) - 1;
      freq[nums[end]] = (freq[nums[end]] ?? 0) + 1;

      final freqEntities = freq.entries.toList()..sort(_compareMapEntry);
      final newValue = freqEntities
          .getRange(0, x > freqEntities.length ? freqEntities.length : x)
          .fold(0, (a, b) => a + b.key * b.value);
      result.add(newValue);

      start++;
      end++;
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> nums;
  final int k, x;

  SolutionTest({
    required this.nums,
    required this.k,
    required this.x,
    required super.result,
  });

  @override
  List<int> computeResult() => Solution().findXSum(nums, k, x);
}

void main(List<String> args) {
  [
    SolutionTest(
        nums: [1, 1, 2, 2, 3, 4, 2, 3], k: 6, x: 2, result: [6, 10, 12]),
    SolutionTest(
        nums: [3, 8, 7, 8, 7, 5], k: 2, x: 2, result: [11, 15, 15, 15, 12]),
    SolutionTest(nums: [9, 2, 2], k: 3, x: 3, result: [13])
  ].test();
}
