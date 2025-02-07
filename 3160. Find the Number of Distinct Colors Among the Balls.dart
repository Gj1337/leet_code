// You are given an integer limit and a 2D array queries of size n x 2.
// There are limit + 1 balls with distinct labels in the range [0, limit].
// Initially, all balls are uncolored.
// For every query in queries that is of the form [x, y],
// you mark ball x with the color y. After each query,
// you need to find the number of distinct colors among the balls.
// Return an array result of length n,
// where result[i] denotes the number of distinct colors after ith query.
// Note that when answering a query,
// lack of a color will not be considered as a color.

// Example 1:
// Input: limit = 4, queries = [[1,4],[2,5],[1,3],[3,4]]
// Output: [1,2,2,3]
// Explanation:
//     After query 0, ball 1 has color 4.
//     After query 1, ball 1 has color 4, and ball 2 has color 5.
//     After query 2, ball 1 has color 3, and ball 2 has color 5.
//     After query 3, ball 1 has color 3, ball 2 has color 5,
//      and ball 3 has color 4.

// Example 2:
// Input: limit = 4, queries = [[0,1],[1,2],[2,2],[3,4],[4,5]]
// Output: [1,2,2,3,4]
// Explanation:
//     After query 0, ball 0 has color 1.
//     After query 1, ball 0 has color 1, and ball 1 has color 2.
//     After query 2, ball 0 has color 1, and balls 1 and 2 have color 2.
//     After query 3, ball 0 has color 1, balls 1 and 2 have color 2,
//       and ball 3 has color 4.
//     After query 4, ball 0 has color 1, balls 1 and 2 have color 2,
//       ball 3 has color 4, and ball 4 has color 5.

// Constraints:
//     1 <= limit <= 109
//     1 <= n == queries.length <= 105
//     queries[i].length == 2
//     0 <= queries[i][0] <= limit
//     1 <= queries[i][1] <= 109

import 'testable.dart';

class Solution {
  List<int> queryResults(int limit, List<List<int>> queries) {
    final result = <int>[];
    final valueColors = <int, int>{};
    final colorFrequency = <int, int>{};
    var colorCount = 0;

    for (final query in queries) {
      final value = query.first;
      final color = query.last;

      final previousColor = valueColors[value];

      if (previousColor != color) {
        if (previousColor != null) {
          colorFrequency[previousColor] =
              (colorFrequency[previousColor] ?? 1) - 1;
        }

        colorFrequency[color] = (colorFrequency[color] ?? 0) + 1;
        valueColors[value] = color;

        if (colorFrequency[previousColor] == 0) {
          colorCount = colorCount > 0 ? colorCount - 1 : 0;
        }

        if (colorFrequency[color] == 1) {
          colorCount++;
        }
      }

      result.add(colorCount);
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  SolutionTest({
    required this.limit,
    required this.queries,
    required super.result,
  });

  final int limit;
  final List<List<int>> queries;

  @override
  List<int> computeResult() => Solution().queryResults(limit, queries);
}

void main(List<String> args) {
  [
    SolutionTest(
      limit: 4,
      queries: [
        [1, 4],
        [2, 5],
        [1, 3],
        [3, 4]
      ],
      result: [1, 2, 2, 3],
    ),
    SolutionTest(
      limit: 4,
      queries: [
        [0, 1],
        [1, 2],
        [2, 2],
        [3, 4],
        [4, 5]
      ],
      result: [1, 2, 2, 3, 4],
    ),
    SolutionTest(
      limit: 2,
      queries: [
        [0, 1],
        [1, 2],
        [0, 1],
        [2, 3]
      ],
      result: [1, 2, 2, 3],
    ),
    SolutionTest(
      limit: 5,
      queries: [
        [0, 1],
        [1, 2],
        [2, 3],
        [3, 4],
        [4, 5],
        [0, 6],
        [1, 7],
        [2, 8]
      ],
      result: [1, 2, 3, 4, 5, 5, 5, 5],
    ),
    SolutionTest(
      limit: 1,
      queries: [
        [0, 1],
        [0, 2],
        [0, 3],
        [0, 4]
      ],
      result: [1, 1, 1, 1],
    ),
    SolutionTest(
      limit: 10,
      queries: [
        [0, 1],
        [1, 2],
        [2, 3],
        [3, 4],
        [4, 5],
        [5, 1],
        [6, 2],
        [7, 3],
        [8, 4],
        [9, 5]
      ],
      result: [1, 2, 3, 4, 5, 5, 5, 5, 5, 5],
    ),
    SolutionTest(
      limit: 0,
      queries: [
        [0, 1],
        [0, 2],
        [0, 3]
      ],
      result: [1, 1, 1],
    )
  ].test();
}
