// You have a long flowerbed in which some of the plots are planted,
// and some are not. However, flowers cannot be planted in adjacent plots.
// Given an integer array flowerbed containing 0's and 1's,
// where 0 means empty and 1 means not empty, and an integer n,
// return true if n new flowers can be planted in the flowerbed
// without violating the no-adjacent-flowers rule and false otherwise.

// Example 1:
// Input: flowerbed = [1,0,0,0,1], n = 1
// Output: true

// Example 2:
// Input: flowerbed = [1,0,0,0,1], n = 2
// Output: false

// Constraints:
//     1 <= flowerbed.length <= 2 * 104
//     flowerbed[i] is 0 or 1.
//     There are no two adjacent flowers in flowerbed.
//     0 <= n <= flowerbed.length

import 'testable.dart';

class Solution {
  bool canPlaceFlowers(List<int> flowerbed, int n) {
    var possiblePotCount = 0;

    flowerbed
      ..add(0)
      ..insert(0, 0);

    print(flowerbed);

    for (var i = 0; i < flowerbed.length - 2; i++) {
      if (flowerbed[i] == 0 && flowerbed[i + 1] == 0 && flowerbed[i + 2] == 0) {
        possiblePotCount++;
        flowerbed[i + 1] = 1;
      }

      if (possiblePotCount == n) return true;
    }

    return possiblePotCount >= n;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  SolutionTest({
    required this.flowerbed,
    required this.n,
    required super.result,
  });

  final List<int> flowerbed;
  final int n;

  @override
  bool computeResult() => Solution().canPlaceFlowers(flowerbed, n);
}

void main(List<String> args) {
  [
    SolutionTest(flowerbed: [1, 0, 0, 0, 1], n: 1, result: true),
    SolutionTest(flowerbed: [1, 0, 0, 0, 1], n: 2, result: false),
    SolutionTest(flowerbed: [1, 0, 0, 0, 0, 1], n: 2, result: false),
    SolutionTest(flowerbed: [0], n: 1, result: true),
  ].test();
}
