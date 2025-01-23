// Given a 32-bit integer num, return a string representing its hexadecimal representation. For negative integers, two’s complement method is used.

// All the letters in the answer string should be lowercase characters, and there should not be any leading zeros in the answer except for the zero itself.

// Note: You are not allowed to use any built-in library method to directly solve this problem.

// Example 1:

// Input: num = 26
// Output: "1a"

// Example 2:

// Input: num = -1
// Output: "ffffffff"

// Constraints:

//     -231 <= num <= 231 - 1

import 'testable.dart';

class Solution {
  static const charMap = {
    0x0: '0',
    0x1: '1',
    0x2: '2',
    0x3: '3',
    0x4: '4',
    0x5: '5',
    0x6: '6',
    0x7: '7',
    0x8: '8',
    0x9: '9',
    0xa: 'a',
    0xb: 'b',
    0xc: 'c',
    0xd: 'd',
    0xe: 'e',
    0xf: 'f',
  };

  String toHex(int num) {
    if (num == 0) return '0';

    var result = '';

    for (var shifter = 0; shifter < bitsTake(num); shifter += 4) {
      final digit = (num & 0x000f << shifter) >> shifter;

      final char = charMap[digit];

      result = '$char$result';
    }

    return result;
  }

  int bitsTake(int num) {
    if (num < 0) return 32;

    int bitsCount = 0;
    while (num > 0) {
      bitsCount++;
      num >>= 1;
    }

    return bitsCount;
  }
}

final class CurrentSolution extends Testable<String> {
  CurrentSolution(
    this.num, {
    required super.result,
  });

  final int num;

  @override
  String computeResult() => Solution().toHex(num);
}

void main(List<String> args) {
  [
    CurrentSolution(0x0, result: 0x0.toRadixString(16)),
    CurrentSolution(0x25, result: 0x25.toRadixString(16)),
    CurrentSolution(0x99, result: 0x99.toRadixString(16)),
    CurrentSolution(-0x1, result: 'ffffffff'),
  ].test();
}
