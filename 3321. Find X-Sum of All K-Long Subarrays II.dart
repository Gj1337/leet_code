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
// nums.length == n
// 1 <= n <= 105
// 1 <= nums[i] <= 109
// 1 <= x <= k <= nums.length

import 'testable.dart';
import 'dart:collection';

class FrequencyPair implements Comparable<FrequencyPair> {
  final int number;
  final int frequency;
  int get sum => number * frequency;

  FrequencyPair(this.number, this.frequency);

  @override
  int get hashCode => Object.hash(number, frequency);

  @override
  int compareTo(FrequencyPair other) => this.frequency != other.frequency
      ? this.frequency.compareTo(other.frequency)
      : this.number.compareTo(other.number);

  @override
  String toString() => '{$number:$frequency}';
}

class Helper {
  final int x;
  int _cachedSum = 0;

  Helper(this.x);

  final freq = <int, int>{};
  final large = SplayTreeSet<FrequencyPair>();
  final small = SplayTreeSet<FrequencyPair>();

  void add(int number) {
    final numFreq = freq[number];
    if (numFreq != null) {
      _internalRemove(FrequencyPair(number, numFreq));
    }

    freq[number] = (freq[number] ?? 0) + 1;
    _internalAdd(FrequencyPair(number, freq[number]!));
  }

  void remove(int number) {
    if (freq[number] != null) {
      _internalRemove(FrequencyPair(number, freq[number]!));
    }

    if (freq[number] == 1) {
      freq.remove(number);
    } else {
      freq[number] = (freq[number] ?? 1) - 1;
    }

    if (freq.containsKey(number) && freq[number]! > 0) {
      _internalAdd(FrequencyPair(number, freq[number]!));
    }
  }

  void _internalAdd(FrequencyPair frequencyPair) {
    if (large.length < x) {
      large.add(frequencyPair);
      _cachedSum += frequencyPair.sum;
      return;
    }

    if (large.first.compareTo(frequencyPair) < 0) {
      small.add(large.first);
      _cachedSum -= large.first.sum;
      large.remove(large.first);

      large.add(frequencyPair);
      _cachedSum += frequencyPair.sum;
    } else {
      small.add(frequencyPair);
    }
  }

  void _internalRemove(FrequencyPair frequencyPair) {
    if (large.contains(frequencyPair)) {
      large.remove(frequencyPair);
      _cachedSum -= frequencyPair.sum;

      if (small.isNotEmpty) {
        final largestSmall = small.last;
        small.remove(largestSmall);

        large.add(largestSmall);
        _cachedSum += largestSmall.sum;
      }
    } else {
      small.remove(frequencyPair);
    }
  }

  int get() => _cachedSum;
}

class Solution {
  List<int> findXSum(List<int> nums, int k, int x) {
    final helper = Helper(x);
    final result = <int>[];

    for (var i = 0; i < nums.length; i++) {
      helper.add(nums[i]);
      if (i >= k) helper.remove(nums[i - k]);
      if (i + 1 >= k) result.add(helper.get());
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
      nums: [1, 1, 2, 2, 3, 4, 2, 3],
      k: 6,
      x: 2,
      result: [6, 10, 12],
    ),
    SolutionTest(
      nums: [3, 8, 7, 8, 7, 5],
      k: 2,
      x: 2,
      result: [11, 15, 15, 15, 12],
    ),
  ].test();
}
