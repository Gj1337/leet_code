// Given an array of strings nums containing n unique binary strings each of length n, return a binary string of length n that does not appear in nums. If there are multiple answers, you may return any of them.
//
// Example 1:
// Input: nums = ["01","10"]
// Output: "11"
// Explanation: "11" does not appear in nums. "00" would also be correct.
//
// Example 2:
// Input: nums = ["00","01"]
// Output: "11"
// Explanation: "11" does not appear in nums. "10" would also be correct.
//
// Example 3:
// Input: nums = ["111","011","001"]
// Output: "101"
// Explanation: "101" does not appear in nums. "000", "010", "100", and "110" would also be correct.
//
// Constraints:
// n == nums.length
// 1 <= n <= 16
// nums[i].length == n
// nums[i] is either '0' or '1'.
// All the strings of nums are unique.

import 'testable.dart';

class Solution {
  String findDifferentBinaryString(List<String> nums) {
    final numsSet = nums.toSet();
    final wordLenght = nums.first.length;

    String generate(String current) {
      if (current.length == wordLenght) {
        return !numsSet.contains(current) ? current : '';
      }

      final addZero = generate('${current}0');
      return addZero.isNotEmpty ? addZero : generate('${current}1');
    }

    return generate('');
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final List<String> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  String computeResult() => Solution().findDifferentBinaryString(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: ["01", "10"], result: "00"),
    SolutionTest(nums: ["00", "01"], result: "10"),
    SolutionTest(nums: ["111", "011", "001"], result: "000"),
  ].test();
}
