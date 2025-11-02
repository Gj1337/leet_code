// You are given two integer

import 'testable.dart';

enum Cell {
  wall,
  guard,
  red,
  green,
}

class Solution {
  int countUnguarded(
    int m,
    int n,
    List<List<int>> guards,
    List<List<int>> walls,
  ) {
    final court = List.generate(m, (_) => List.filled(n, Cell.green));

    for (final wall in walls) {
      court[wall.first][wall.last] = Cell.wall;
    }

    for (final guard in guards) {
      court[guard.first][guard.last] = Cell.guard;
    }

    var occupied = walls.length + guards.length;

    for (final guard in guards) {
      for (var i = guard.first - 1; i >= 0; i--) {
        final cell = court[i][guard.last];

        if (cell == Cell.guard || cell == Cell.wall) {
          break;
        } else if (cell == Cell.green) {
          court[i][guard.last] = Cell.red;
          occupied++;
        }
      }

      for (var i = guard.first + 1; i < m; i++) {
        final cell = court[i][guard.last];

        if (cell == Cell.guard || cell == Cell.wall) {
          break;
        } else if (cell == Cell.green) {
          court[i][guard.last] = Cell.red;
          occupied++;
        }
      }

      for (var j = guard.last - 1; j >= 0; j--) {
        final cell = court[guard.first][j];

        if (cell == Cell.guard || cell == Cell.wall) {
          break;
        } else if (cell == Cell.green) {
          court[guard.first][j] = Cell.red;
          occupied++;
        }
      }

      for (var j = guard.last + 1; j < n; j++) {
        final cell = court[guard.first][j];

        if (cell == Cell.guard || cell == Cell.wall) {
          break;
        } else if (cell == Cell.green) {
          court[guard.first][j] = Cell.red;
          occupied++;
        }
      }
    }

    court.forEach(
      (line) => print(
        line
            .map(
              (cell) => switch (cell) {
                Cell.wall => 'W',
                Cell.guard => 'G',
                Cell.red => '\x1B[41m \x1B[0m',
                Cell.green => '\x1B[42m \x1B[0m',
              },
            )
            .join(),
      ),
    );

    return m * n - occupied;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final int m, n;
  final List<List<int>> guards, walls;

  SolutionTest(
      {required this.m,
      required this.n,
      required this.guards,
      required this.walls,
      required super.result});

  @override
  int computeResult() => Solution().countUnguarded(m, n, guards, walls);
}

void main(List<String> args) {
  [
    SolutionTest(
        m: 4,
        n: 6,
        guards: [
          [0, 0],
          [1, 1],
          [2, 3]
        ],
        walls: [
          [0, 1],
          [2, 2],
          [1, 4]
        ],
        result: 7),
    SolutionTest(
        m: 3,
        n: 3,
        guards: [
          [1, 1]
        ],
        walls: [
          [0, 1],
          [1, 0],
          [2, 1],
          [1, 2]
        ],
        result: 4),
    SolutionTest(
        m: 5,
        n: 5,
        guards: [
          [1, 4],
          [4, 1],
          [0, 3]
        ],
        walls: [
          [3, 2]
        ],
        result: 3),
    SolutionTest(
      m: 6,
      n: 10,
      guards: [
        [0, 6],
        [2, 2],
        [2, 5],
        [1, 2],
        [4, 9],
        [2, 9],
        [5, 6],
        [4, 6]
      ],
      walls: [
        [1, 5]
      ],
      result: 8,
    ),
    SolutionTest(
        m: 10,
        n: 8,
        guards: [
          [6, 4],
          [4, 5],
          [0, 3],
          [8, 2],
          [6, 3]
        ],
        walls: [
          [7, 2]
        ],
        result: 28),
  ].test();
}
