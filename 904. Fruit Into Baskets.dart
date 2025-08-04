// You are visiting a farm that has a single row of fruit trees arranged
// from left to right.
// The trees are represented by an integer array fruits where
// fruits[i] is the type of fruit the ith tree produces.
// You want to collect as much fruit as possible.
// However, the owner has some strict rules that you must follow:
//     You only have two baskets, and each basket
//     can only hold a single type of fruit.
//     There is no limit on the amount of fruit each basket can hold.
//     Starting from any tree of your choice, you must pick
//     exactly one fruit from every tree (including the start tree)
//     while moving to the right.
//     The picked fruits must fit in one of your baskets.
//     Once you reach a tree with fruit that cannot fit in your baskets,
//     you must stop.
// Given the integer array fruits,
// return the maximum number of fruits you can pick.

// Example 1:
// Input: fruits = [1,2,1]
// Output: 3
// Explanation: We can pick from all 3 trees.

// Example 2:
// Input: fruits = [0,1,2,2]
// Output: 3
// Explanation: We can pick from trees [1,2,2].
// If we had started at the first tree, we would only pick from trees [0,1].

// Example 3:
// Input: fruits = [1,2,3,2,2]
// Output: 4
// Explanation: We can pick from trees [2,3,2,2].
// If we had started at the first tree, we would only pick from trees [1,2].

// Constraints:
//     1 <= fruits.length <= 105
//     0 <= fruits[i] < fruits.length

import 'testable.dart';

class Solution {
  int totalFruit(List<int> fruits) {
    final basket = <int, int>{};
    var leftPointer = 0;
    var rightPointer = 0;
    var maxLength = 0;

    while (rightPointer < fruits.length) {
      basket[fruits[rightPointer]] = (basket[fruits[rightPointer]] ?? 0) + 1;
      rightPointer++;

      while (basket.length > 2) {
        basket[fruits[leftPointer]] = (basket[fruits[leftPointer]] ?? 0) - 1;
        if (basket[fruits[leftPointer]] == 0) {
          basket.remove(fruits[leftPointer]);
        }
        leftPointer++;
      }

      final length = rightPointer - leftPointer;
      maxLength = maxLength > length ? maxLength : length;
    }

    return maxLength;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.fruits, required super.result});

  final List<int> fruits;

  @override
  int computeResult() => Solution().totalFruit(fruits);
}

void main(List<String> args) {
  [
    SolutionTest(fruits: [1, 2, 1], result: 3),
    SolutionTest(fruits: [0, 1, 2, 2], result: 3),
    SolutionTest(fruits: [1, 2, 3, 2, 2], result: 4),
    SolutionTest(
        fruits: [1, 2, 3, 2, 3, 2, 3, 2, 4, 4, 4, 5, 5, 5, 4, 4, 3, 3, 2, 2],
        result: 8)
  ].test();
}
