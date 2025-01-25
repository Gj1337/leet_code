// Given an integer n, return a string array answer (1-indexed) where:

// answer[i] == "FizzBuzz" if i is divisible by 3 and 5.
// answer[i] == "Fizz" if i is divisible by 3.
// answer[i] == "Buzz" if i is divisible by 5.
// answer[i] == i (as a string) if none of the above conditions are true.

// Example 1:

// Input: n = 3
// Output: ["1","2","Fizz"]
// Example 2:

// Input: n = 5
// Output: ["1","2","Fizz","4","Buzz"]
// Example 3:

// Input: n = 15
// Output: ["1","2","Fizz","4","Buzz","Fizz","7","8","Fizz","Buzz","11","Fizz","13","14","FizzBuzz"]

// Constraints:

// 1 <= n <= 104

import 'testable.dart';

class Solution {
  List<String> fizzBuzz(int n) {
    final result = <String>[];

    for (var i = 1; i < n + 1; i++) {
      result.add(
        switch (i) {
          _ when i % 3 == 0 && i % 5 == 0 => 'FizzBuzz',
          _ when i % 3 == 0 => 'Fizz',
          _ when i % 5 == 0 => 'Buzz',
          _ => '$i',
        },
      );
    }

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  SolutionTest({
    required this.n,
    required super.result,
  });

  final int n;

  @override
  computeResult() => Solution().fizzBuzz(n);
}

void main(List<String> args) {
  [
    SolutionTest(n: 1, result: ['1']),
    SolutionTest(n: 2, result: ['1', '2']),
    SolutionTest(n: 3, result: ['1', '2', 'Fizz']),
    SolutionTest(n: 5, result: ['1', '2', 'Fizz', '4', 'Buzz']),
    SolutionTest(n: 6, result: ['1', '2', 'Fizz', '4', 'Buzz', 'Fizz']),
    SolutionTest(n: 10, result: [
      '1',
      '2',
      'Fizz',
      '4',
      'Buzz',
      'Fizz',
      '7',
      '8',
      'Fizz',
      'Buzz'
    ]),
    SolutionTest(n: 15, result: [
      '1',
      '2',
      'Fizz',
      '4',
      'Buzz',
      'Fizz',
      '7',
      '8',
      'Fizz',
      'Buzz',
      '11',
      'Fizz',
      '13',
      '14',
      'FizzBuzz'
    ]),
    SolutionTest(n: 0, result: []), // Edge case
    SolutionTest(n: 16, result: [
      '1',
      '2',
      'Fizz',
      '4',
      'Buzz',
      'Fizz',
      '7',
      '8',
      'Fizz',
      'Buzz',
      '11',
      'Fizz',
      '13',
      '14',
      'FizzBuzz',
      '16'
    ]),
  ].test();
}
