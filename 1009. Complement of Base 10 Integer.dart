// The complement of an integer is the integer you get when you flip all the 0's to 1's and all the 1's to 0's in its binary representation.
//
// For example, The integer 5 is "101" in binary and its complement is "010" which is the integer 2.
// Given an integer n, return its complement.
//
// Example 1:
// Input: n = 5
// Output: 2
// Explanation: 5 is "101" in binary, with complement "010" in binary, which is 2 in base-10.
//
// Example 2:
// Input: n = 7
// Output: 0
// Explanation: 7 is "111" in binary, with complement "000" in binary, which is 0 in base-10.
//
// Example 3:
// Input: n = 10
// Output: 5
// Explanation: 10 is "1010" in binary, with complement "0101" in binary, which is 5 in base-10.
//
// Constraints:
// 0 <= n < 109

import 'testable.dart';

class Solution {
  int bitwiseComplement(int n) {
    if (n == 0) return 1;
    if (n == 1) return 0;

    final bitLength = n.bitLength;
    final mask = (1 << bitLength) - 1;

    return n ^ mask;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  int computeResult() => Solution().bitwiseComplement(n);
}

void main(List<String> args) {
  [
    // --- Basic Examples ---
    SolutionTest(n: 5, result: 2), // 101 -> 010
    SolutionTest(n: 10, result: 5), // 1010 -> 0101
    // --- The "Tricky" Edge Cases ---
    SolutionTest(n: 0, result: 1), // 0 is "0", complement is "1"
    SolutionTest(n: 1, result: 0), // 1 is "1", complement is "0"
    // --- All Bits are 1 (Result should always be 0) ---
    SolutionTest(n: 7, result: 0), // 111 -> 000
    SolutionTest(n: 31, result: 0), // 11111 -> 00000
    SolutionTest(n: 255, result: 0), // 11111111 -> 00000000
    // --- Powers of 2 (1 followed by 0s) ---
    SolutionTest(n: 8, result: 7), // 1000 -> 0111
    SolutionTest(n: 16, result: 15), // 10000 -> 01111
    SolutionTest(n: 1024, result: 1023),

    // --- Alternating Bit Patterns ---
    SolutionTest(n: 42, result: 21), // 101010 -> 010101
    SolutionTest(n: 21, result: 10), // 10101 -> 01010 (Note: bit length is 5)
    // --- Maximum Constraint (n < 10^9) ---
    // 1,000,000,000 in binary: 111011100110101100101000000000 (30 bits)
    SolutionTest(n: 1000000000, result: 73741823),
  ].test();
}
