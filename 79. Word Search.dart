// Given an m x n grid of characters board and a string word, return true if word exists in the grid.
// The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.
//
// Example 1:
// Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
// Output: true
//
// Example 2:
// Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
// Output: true
//
// Example 3:
// Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
// Output: false
//
// Constraints:
// m == board.length
// n = board[i].length
// 1 <= m, n <= 6
// 1 <= word.length <= 15
// board and word consists of only lowercase and uppercase English letters.

import 'testable.dart';

class Solution {
  bool exist(List<List<String>> board, String word) {
    final letters = word.split('');
    for (var line in board) {
      for (var letter in line) {
        letters.remove(letter);
      }
    }
    if (letters.isNotEmpty) return false;

    bool dfs(int i, int j, {int index = 0}) {
      final searchableLetter = word[index];

      if (board[i][j] == searchableLetter) {
        board[i][j] = '#';
        if (index == word.length - 1) return true;

        final moveLeft = j > 0 ? dfs(i, j - 1, index: index + 1) : false;
        final moveRight = j < board[i].length - 1
            ? dfs(i, j + 1, index: index + 1)
            : false;
        final moveUp = i > 0 ? dfs(i - 1, j, index: index + 1) : false;
        final moveDown = i < board.length - 1
            ? dfs(i + 1, j, index: index + 1)
            : false;

        board[i][j] = searchableLetter;
        return (moveLeft || moveRight || moveUp || moveDown);
      } else {
        return false;
      }
    }

    for (var i = 0; i < board.length; i++) {
      for (var j = 0; j < board[i].length; j++) {
        if (dfs(i, j)) return true;
      }
    }

    return false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final List<List<String>> board;
  final String word;

  SolutionTest({
    required this.board,
    required this.word,
    required super.result,
  });

  @override
  bool computeResult() => Solution().exist(board, word);
}

void main(List<String> args) {
  [
    SolutionTest(
      board: [
        ["A", "B", "C", "E"],
        ["S", "F", "C", "S"],
        ["A", "D", "E", "E"],
      ],
      word: "ABCCED",
      result: true,
    ),
    SolutionTest(
      board: [
        ["A", "B", "C", "E"],
        ["S", "F", "C", "S"],
        ["A", "D", "E", "E"],
      ],
      word: "SEE",
      result: true,
    ),
    SolutionTest(
      board: [
        ["A", "B", "C", "E"],
        ["S", "F", "C", "S"],
        ["A", "D", "E", "E"],
      ],
      word: "ABCB",
      result: false,
    ),
    SolutionTest(
      board: [
        ["A", "B", "C", "E"],
        ["S", "F", "E", "S"],
        ["A", "D", "E", "E"],
      ],
      word: "ABCESEEEFS",
      result: true,
    ),
    SolutionTest(
      board: [
        ["A", "A", "A", "A", "A", "A"],
        ["A", "A", "A", "A", "A", "A"],
        ["A", "A", "A", "A", "A", "A"],
        ["A", "A", "A", "A", "A", "A"],
        ["A", "A", "A", "A", "A", "A"],
        ["A", "A", "A", "A", "A", "A"],
      ],
      word: "AAAAAAAAAAAAAAB",
      result: false,
    ),
  ].test();
}
