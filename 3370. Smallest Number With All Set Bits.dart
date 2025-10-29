// You are given a positive number n.
//
// Return the smallest number x greater than or equal to n, such that the binary representation of x contains only set bits
//
// Example 1:
// Input: n = 5
// Output: 7
// Explanation:
// The binary representation of 7 is "111".
//
// Example 2:
// Input: n = 10
// Output: 15
// Explanation:
// The binary representation of 15 is "1111".
//
// Example 3:
// Input: n = 3
// Output: 3
// Explanation:
// The binary representation of 3 is "11".
//
// Constraints:
//
// 1 <= n <= 1000

import 'testable.dart';

class Solution {
  int smallestNumber(int n) {
    for (var i = 1; i <= 32; i <<= 1) n |= n >> i;

    return n;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().smallestNumber(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 5, result: 7),
    SolutionTest(n: 10, result: 15),
    SolutionTest(n: 3, result: 3),
  ].test();
}
