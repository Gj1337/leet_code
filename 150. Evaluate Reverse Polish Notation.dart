// You are given an array of strings tokens that represents an arithmetic expression in a Reverse Polish Notation.
// Evaluate the expression. Return an integer that represents the value of the expression.
// Note that:
// The valid operators are '+', '-', '*', and '/'.
// Each operand may be an integer or another expression.
// The division between two integers always truncates toward zero.
// There will not be any division by zero.
// The input represents a valid arithmetic expression in a reverse polish notation.
// The answer and all the intermediate calculations can be represented in a 32-bit integer.
//
// Example 1:
// Input: tokens = ["2","1","+","3","*"]
// Output: 9
// Explanation: ((2 + 1) * 3) = 9
//
// Example 2:
// Input: tokens = ["4","13","5","/","+"]
// Output: 6
// Explanation: (4 + (13 / 5)) = 6
//
// Example 3:
// Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
// Output: 22
// Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
// = ((10 * (6 / (12 * -11))) + 17) + 5
// = ((10 * (6 / -132)) + 17) + 5
// = ((10 * 0) + 17) + 5
// = (0 + 17) + 5
// = 17 + 5
// = 22
//
// Constraints:
// 1 <= tokens.length <= 104
// tokens[i] is either an operator: "+", "-", "*", or "/", or an integer in the range [-200, 200].

import 'testable.dart';

class Solution {
  int evalRPN(List<String> tokens) {
    final stack = <int>[];

    for (final token in tokens) {
      final isOperator = switch (token) {
        '+' || '-' || '*' || '/' => true,
        _ => false,
      };

      if (isOperator) {
        final right = stack.removeLast();
        final left = stack.removeLast();
        final result = switch (token) {
          '/' => left ~/ right,
          '*' => left * right,
          '-' => left - right,
          _ => left + right,
        };
        stack.add(result);
      } else {
        stack.add(int.parse(token));
      }
    }

    return stack.last;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<String> tokens;

  SolutionTest({required this.tokens, required super.result});

  @override
  int computeResult() => Solution().evalRPN(tokens);
}

main() {
  [
    SolutionTest(tokens: ["2", "1", "+", "3", "*"], result: 9),
    SolutionTest(tokens: ["4", "13", "5", "/", "+"], result: 6),
    SolutionTest(
      tokens: [
        "10",
        "6",
        "9",
        "3",
        "+",
        "-11",
        "*",
        "/",
        "*",
        "17",
        "+",
        "5",
        "+",
      ],
      result: 22,
    ),
  ].test();
}
