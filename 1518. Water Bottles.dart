// There are numBottles water bottles that are initially full of water. You can exchange numExchange empty water bottles from the market with one full water bottle.
// The operation of drinking a full water bottle turns it into an empty bottle.
// Given the two integers numBottles and numExchange, return the maximum number of water bottles you can drink.
//
// Example 1:
// Input: numBottles = 9, numExchange = 3
// Output: 13
// Explanation: You can exchange 3 empty bottles to get 1 full water bottle.
// Number of water bottles you can drink: 9 + 3 + 1 = 13.
//
// Example 2:
// Input: numBottles = 15, numExchange = 4
// Output: 19
// Explanation: You can exchange 4 empty bottles to get 1 full water bottle.
// Number of water bottles you can drink: 15 + 3 + 1 = 19.
//
// Constraints:
//
//     1 <= numBottles <= 100
//     2 <= numExchange <= 100

import 'testable.dart';

class Solution {
  int numWaterBottles(int numBottles, int numExchange) {
    var conumedBottles = 0;
    var emptyBottles = 0;

    while (numBottles != 0) {
      conumedBottles += numBottles;
      emptyBottles += numBottles;

      numBottles = emptyBottles ~/ numExchange;
      emptyBottles -= numBottles * numExchange;
    }

    return conumedBottles;
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
  int computeResult() => Solution().numWaterBottles(numBottles, numExchange);
}

void main(List<String> args) {
  [
    SoutionTest(numBottles: 9, numExchange: 3, result: 13),
    SoutionTest(numBottles: 15, numExchange: 4, result: 19),
  ].test();
}
