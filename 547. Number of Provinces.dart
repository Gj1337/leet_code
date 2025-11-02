// There are n cities. Some of them are connected, while some are not. If city a is connected directly with city b, and city b is connected directly with city c, then city a is connected indirectly with city c.
//
// A province is a group of directly or indirectly connected cities and no other cities outside of the group.
//
// You are given an n x n matrix isConnected where isConnected[i][j] = 1 if the ith city and the jth city are directly connected, and isConnected[i][j] = 0 otherwise.
//
// Return the total number of provinces.
//
// Example 1:
// Input: isConnected = [[1,1,0],[1,1,0],[0,0,1]]
// Output: 2
//
// Example 2:
// Input: isConnected = [[1,0,0],[0,1,0],[0,0,1]]
// Output: 3
//
// Constraints:
//     1 <= n <= 200
//     n == isConnected.length
//     n == isConnected[i].length
//     isConnected[i][j] is 1 or 0.
//     isConnected[i][i] == 1
//     isConnected[i][j] == isConnected[j][i]

import 'testable.dart';

class Solution {
  int findCircleNum(List<List<int>> isConnected) {
    var result = 0;
    final visited = List.filled(isConnected.length, false);

    void dfs(final int node) {
      visited[node] = true;

      for (var i = 0; i < isConnected[node].length; i++) {
        if (isConnected[node][i] == 1 && !visited[i]) {
          dfs(i);
        }
      }
    }

    for (var i = 0; i < isConnected.length; i++) {
      if (!visited[i]) {
        result++;
        dfs(i);
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<List<int>> isConnected;

  SolutionTest({required this.isConnected, required super.result});

  @override
  int computeResult() => Solution().findCircleNum(isConnected);
}

void main(List<String> args) {
  [
    SolutionTest(isConnected: [
      [1, 1, 0],
      [1, 1, 0],
      [0, 0, 1]
    ], result: 2),
    SolutionTest(isConnected: [
      [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1]
    ], result: 3),
  ].test();
}
