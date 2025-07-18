// Given two positive integers n and k,
// the binary string Sn is formed as follows:
//     S1 = "0"
//     Si = S[i - 1] + "1" + reverse(invert[Si - 1]) for i > 1
// Where + denotes the concatenation operation,
// reverse(x) returns the reversed string x,
// and invert(x) inverts all the bits
// in x (0 changes to 1 and 1 changes to 0).

// For example, the first four strings in the above sequence are:
//     S1 = "0"
//     S2 = "011"
//     S3 = "0111001"
//     S4 = "011100110110001"

// Return the kth bit in Sn.
// It is guaranteed that k is valid for the given n.

// Example 1:
// Input: n = 3, k = 1
// Output: "0"
// Explanation: S3 is "0111001".
// The 1st bit is "0".

// Example 2:
// Input: n = 4, k = 11
// Output: "1"
// Explanation: S4 is "011100110110001".
// The 11th bit is "1".

// Constraints:
//     1 <= n <= 20
//     1 <= k <= 2n - 1

import 'testable.dart';

class Solution {
  String findKthBit(int n, int k) {
    if (n == 1) return '0';

    final snthLenght = 1 << n;

    return switch (snthLenght ~/ 2) {
      (var middleOfSnth) when middleOfSnth > k => findKthBit(n - 1, k),
      (var middleOfSnth) when middleOfSnth < k =>
        findKthBit(n - 1, snthLenght - k) == '0' ? '1' : '0',
      _ => '1',
    };
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({required this.n, required this.k, required super.result});

  final int n;
  final int k;

  @override
  String computeResult() => Solution().findKthBit(n, k);
}

void main(List<String> args) {
  [
    SolutionTest(n: 3, k: 1, result: "0"),
    SolutionTest(n: 4, k: 11, result: "1"),
  ].test();
}
