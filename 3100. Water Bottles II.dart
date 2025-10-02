// You are given two integers numBottles and numExchange.
// numBottles represents the number of full water bottles that you initially have. In one operation, you can perform one of the following operations:
//     Drink any number of full water bottles turning them into empty bottles.
//     Exchange numExchange empty bottles with one full water bottle. Then, increase numExchange by one.
// Note that you cannot exchange multiple batches of empty bottles for the same value of numExchange. For example, if numBottles == 3 and numExchange == 1, you cannot exchange 3 empty water bottles for 3 full bottles.
// Return the maximum number of water bottles you can drink.

// Example 1:
// Input: numBottles = 13, numExchange = 6
// Output: 15

// Example 2:
// Input: numBottles = 10, numExchange = 3
// Output: 13

// Constraints:
//     1 <= numBottles <= 100
//     1 <= numExchange <= 100

import 'testable.dart';

class Solution {
  int maxBottlesDrunk(int numBottles, int numExchange) {
    var consumedBottles = 0;
    var emptyBottles = 0;

    while (numBottles != 0) {
      consumedBottles += numBottles;
      emptyBottles += numBottles;
      numBottles = 0;

      while (emptyBottles >= numExchange) {
        numBottles++;
        emptyBottles -= numExchange;
        numExchange++;
      }
    }

    return consumedBottles;
  }
}

class SoutionTest extends Testable<int> with ConsoleTestOutput {
  final int numBottles, numExchange;

  SoutionTest({
    required this.numBottles,
    required this.numExchange,
    required super.result,
  });

  @override
  int computeResult() => Solution().maxBottlesDrunk(numBottles, numExchange);
}

void main(List<String> args) {
  [
    SoutionTest(numBottles: 13, numExchange: 6, result: 15),
    SoutionTest(numBottles: 10, numExchange: 3, result: 13),
  ].test();
}
