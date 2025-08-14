// You are given a string num representing a large integer.
// An integer is good if it meets the following conditions:
//     It is a substring of num with length 3.
//     It consists of only one unique digit.
// Return the maximum good integer as a string or
// an empty string "" if no such integer exists.

// Note:
//     A substring is a contiguous sequence of characters within a string.
//     There may be leading zeroes in num or a good integer.

// Example 1:
// Input: num = "6777133339"
// Output: "777"
// Explanation: There are two distinct good integers: "777" and "333".
// "777" is the largest, so we return "777".

// Example 2:
// Input: num = "2300019"
// Output: "000"
// Explanation: "000" is the only good integer.

// Example 3:
// Input: num = "42352338"
// Output: ""
// Explanation: No substring of length 3 consists of only one unique digit.
// Therefore, there are no good integers.

// Constraints:
//     3 <= num.length <= 1000
//     num only consists of digits.

import 'testable.dart';

class Solution {
  String largestGoodInteger(String num) {
    const numbers = [
      '999','888','777','666','555',
      '444','333','222','111','000'
    ];

    for (final number in numbers) {
      if (num.contains(number)) return number;
    }

    return '';
  }

  // String largestGoodInteger(String num) {
  //   var resultNumber = -1;
  //   var resultString = '';

  //   for (var i = 2; i < num.length; i++) {
  //     if (num[i - 2] == num[i - 1] && num[i - 1] == num[i]) {
  //       final numString = '${num[i - 2]}${num[i - 1]}${num[i]}';

  //       var number = int.parse(numString);

  //       if (number > resultNumber) {
  //         resultNumber = number;
  //         resultString = numString;
  //       }
  //     }
  //   }

  //   return resultString;
  // }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  SolutionTest({required this.num, required super.result});

  final String num;

  @override
  String computeResult() => Solution().largestGoodInteger(num);
}

main() {
  [
    SolutionTest(num: "222", result: "222"),
    SolutionTest(num: "6777133339", result: "777"),
    SolutionTest(num: "2300019", result: "000"),
    SolutionTest(num: "42352338", result: "")
  ].test();
}
