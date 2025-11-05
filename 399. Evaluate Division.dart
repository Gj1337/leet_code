// You are given an array of variable pairs equations and an array of real numbers values, where equations[i] = [Ai, Bi] and values[i] represent the equation Ai / Bi = values[i]. Each Ai or Bi is a string that represents a single variable.
//
// You are also given some queries, where queries[j] = [Cj, Dj] represents the jth query where you must find the answer for Cj / Dj = ?.
//
// Return the answers to all queries. If a single answer cannot be determined, return -1.0.
//
// Note: The input is always valid. You may assume that evaluating the queries will not result in division by zero and that there is no contradiction.
//
// Note: The variables that do not occur in the list of equations are undefined, so the answer cannot be determined for them.
//
// Example 1:
// Input: equations = [["a","b"],["b","c"]], values = [2.0,3.0], queries = [["a","c"],["b","a"],["a","e"],["a","a"],["x","x"]]
// Output: [6.00000,0.50000,-1.00000,1.00000,-1.00000]
// Explanation:
// Given: a / b = 2.0, b / c = 3.0
// queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ?
// return: [6.0, 0.5, -1.0, 1.0, -1.0 ]
// note: x is undefined => -1.0
//
// Example 2:
// Input: equations = [["a","b"],["b","c"],["bc","cd"]], values = [1.5,2.5,5.0], queries = [["a","c"],["c","b"],["bc","cd"],["cd","bc"]]
// Output: [3.75000,0.40000,5.00000,0.20000]
//
// Example 3:
// Input: equations = [["a","b"]], values = [0.5], queries = [["a","b"],["b","a"],["a","c"],["x","y"]]
// Output: [0.50000,2.00000,-1.00000,-1.00000]
//
// Constraints:
// 1 <= equations.length <= 20
// equations[i].length == 2
// 1 <= Ai.length, Bi.length <= 5
// values.length == equations.length
// 0.0 < values[i] <= 20.0
// 1 <= queries.length <= 20
// queries[i].length == 2
// 1 <= Cj.length, Dj.length <= 5
// Ai, Bi, Cj, Dj consist of lower case English letters and digits.

import 'testable.dart';

class Solution {
  List<double> calcEquation(List<List<String>> equations, List<double> values,
      List<List<String>> queries) {
    final graph = <String, List<({String to, double value})>>{};
    for (var i = 0; i < equations.length && i < values.length; i++) {
      final from = equations[i].first;
      final to = equations[i].last;
      final value = values[i];

      if (graph[from] == null) graph[from] = [];
      graph[from]?.add((to: to, value: value));

      if (graph[to] == null) graph[to] = [];
      graph[to]?.add((to: from, value: 1 / value));
    }

    double dfs(String start, String finish, Set<String> seen) {
      if (!graph.containsKey(start) || !graph.containsKey(finish)) return -1.0;
      if (start == finish) return 1.0;
      seen.add(start);

      for (var i = 0; i < graph[start]!.length; i++) {
        final node = graph[start]![i];
        if (seen.contains(node.to)) continue;
        if (node.to == finish) return node.value;
        final result = dfs(node.to, finish, seen);
        if (result != -1) return node.value * result;
      }

      return -1;
    }

    return queries.map((query) => dfs(query.first, query.last, {})).toList();
  }
}

class SolutionTest extends Testable<List<double>> with ConsoleTestOutput {
  final List<List<String>> equations;
  final List<double> values;
  final List<List<String>> queries;

  SolutionTest({
    required this.equations,
    required this.values,
    required this.queries,
    required super.result,
  });

  @override
  List<double> computeResult() =>
      Solution().calcEquation(equations, values, queries);
}

void main(List<String> args) {
  [
    SolutionTest(
      equations: [
        ["a", "b"],
        ["b", "c"]
      ],
      values: [2.0, 3.0],
      queries: [
        ["a", "c"],
        ["b", "a"],
        ["a", "e"],
        ["a", "a"],
        ["x", "x"]
      ],
      result: [6.00000, 0.50000, -1.00000, 1.00000, -1.00000],
    ),
    SolutionTest(
      equations: [
        ["a", "b"],
        ["b", "c"],
        ["bc", "cd"]
      ],
      values: [1.5, 2.5, 5.0],
      queries: [
        ["a", "c"],
        ["c", "b"],
        ["bc", "cd"],
        ["cd", "bc"]
      ],
      result: [3.75000, 0.40000, 5.00000, 0.20000],
    ),
    SolutionTest(
      equations: [
        ["a", "b"]
      ],
      values: [0.5],
      queries: [
        ["a", "b"],
        ["b", "a"],
        ["a", "c"],
        ["x", "y"]
      ],
      result: [0.50000, 2.00000, -1.00000, -1.00000],
    ),
  ].test();
}
