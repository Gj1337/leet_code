// Given an integer n,
// return any array containing n unique integers such that they add up to 0.

// Example 1:
// Input: n = 5
// Output: [-7,-1,1,3,4]
// Explanation: These arrays also are accepted [-5,-1,1,2,3] , [-3,-1,2,-2,4].

// Example 2:
// Input: n = 3
// Output: [-1,0,1]
// Example 3:

// Input: n = 1
// Output: [0]

// Constraints:
//     1 <= n <= 1000

import 'testable.dart';

class Solution {
  List<int> sumZero(int n) {
    final result = <int>[];
    final isEven = (1 & n) == 0;
    if (!isEven) result.add(0);

    for (var i = 1; i < n; i += 2) {
      result.addAll([-i, i]);
    }

    return result;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final int n;

  SolutionTest({required this.n, required super.result});

  @override
  bool computeResult() {
    final list = Solution().sumZero(n);
    if (list.length != n) return false;

    final sum = list.reduce((sum, next) => sum + next);
    if (sum != 0) return false;

    return true;
  }
}

void main(List<String> args) {
  [SolutionTest(n: 5, result: true)].test();
}
