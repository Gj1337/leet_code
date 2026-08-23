// Given an array nums of integers, return how many of them contain an even number of digits.
//
// Example 1:
//
// Input: nums = [12,345,2,6,7896]
// Output: 2
// Explanation:
// 12 contains 2 digits (even number of digits).
// 345 contains 3 digits (odd number of digits).
// 2 contains 1 digit (odd number of digits).
// 6 contains 1 digit (odd number of digits).
// 7896 contains 4 digits (even number of digits).
// Therefore only 12 and 7896 contain an even number of digits.
// Example 2:
//
// Input: nums = [555,901,482,1771]
// Output: 1
// Explanation:
// Only 1771 contains an even number of digits.
//
// Constraints:
// 1 <= nums.length <= 500
// 1 <= nums[i] <= 105

import 'testable.dart';

class Solution {
  int getNumberOfDigits(int number) {
    var result = 1;

    var processedNumber = number ~/ 10;

    while (processedNumber > 0) {
      result += 1;
      number = processedNumber;
      processedNumber = number ~/ 10;
    }

    return result;
  }

  int findNumbers(List<int> nums) {
    var result = 0;

    for (var number in nums) {
      final digitCount = getNumberOfDigits(number);
      if (digitCount.isEven) result += 1;
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  new({required this.nums, required super.result});

  @override
  int computeResult() => Solution().findNumbers(this.nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [12, 345, 2, 6, 7896], result: 2),
    SolutionTest(nums: [555, 901, 482, 1771], result: 1),
  ].test();
}
