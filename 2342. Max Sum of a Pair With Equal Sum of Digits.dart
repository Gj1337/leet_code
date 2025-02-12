// You are given a 0-indexed array nums consisting of positive integers.
// You can choose two indices i and j,
// such that i != j, and the sum of digits of
// the number nums[i] is equal to that of nums[j].
// Return the maximum value of nums[i] + nums[j]
// that you can obtain over all possible indices i and j
// that satisfy the conditions.

// Example 1:
// Input: nums = [18,43,36,13,7]
// Output: 54
// Explanation: The pairs (i, j) that satisfy the conditions are:
// - (0, 2), both numbers have a sum of digits equal to 9,
//  and their sum is 18 + 36 = 54.
// - (1, 4), both numbers have a sum of digits equal to 7,
//  and their sum is 43 + 7 = 50.
// So the maximum sum that we can obtain is 54.

// Example 2:
// Input: nums = [10,12,19,14]
// Output: -1
// Explanation: There are no two numbers that satisfy the conditions,
// so we return -1.

// Constraints:
//     1 <= nums.length <= 105
//     1 <= nums[i] <= 109

import 'testable.dart';

class SortedPair {
  int? _first;
  int? _second;

  void add(int number) {
    if (_first == null) {
      _first = number;
    } else if (_second == null) {
      _second = number;
    } else {
      if (number > _second! && number < _first!) {
        _second = number;
      } else if (number > _first! && number < _second!) {
        _first = number;
      } else if (number > _first! && number > _second!) {
        if (_second! > _first!) {
          _first = _second;
          _second = number;
        } else {
          _second = _first;
          _first = number;
        }
      }
    }
  }

  bool get isFullfiled => !(_first == null || _second == null);

  int get sum =>
      isFullfiled ? _first! + _second! : (throw Exception('Isn\'t fullfiled'));

  @override
  String toString() => '{$_first,$_second}';
}

class Solution {
  int maximumSum(List<int> nums) {
    final digitSumMap = <int, SortedPair>{};

    nums.forEach(
      (num) {
        final digitSum = num.getDigitSum;

        if (digitSumMap[digitSum] == null) {
          digitSumMap[digitSum] = SortedPair();
        }

        digitSumMap[digitSum]?.add(num);
      },
    );

    final sums = digitSumMap.values
        .where((pair) => pair.isFullfiled)
        .map((pair) => pair.sum);

    return sums.isNotEmpty ? sums.reduce((a, b) => a > b ? a : b) : -1;
  }
}

extension _ on int {
  int get getDigitSum {
    if (this < 10) return this;

    var value = this;
    var result = 0;

    while (value > 0) {
      result += value % 10;

      value ~/= 10;
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.nums,
    required super.result,
  });

  final List<int> nums;

  @override
  int computeResult() => Solution().maximumSum(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [18, 43, 36, 13, 7], result: 54),
    SolutionTest(nums: [4, 6, 10, 6], result: 12),
    SolutionTest(nums: [10, 12, 19, 14], result: -1),
    SolutionTest(nums: [
      243,
      205,
      369,
      253,
      72,
      484,
      300,
      161,
      188,
      69,
      309,
      96,
      226,
      308,
      252
    ], result: 495)
  ].test();
}
