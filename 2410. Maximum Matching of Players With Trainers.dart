// You are given a 0-indexed integer array players,
// where players[i] represents the ability of the ith player.
// You are also given a 0-indexed integer array trainers,
// where trainers[j] represents the training capacity of the jth trainer.
// The ith player can match with the jth trainer
// if the player's ability is less than or equal
// to the trainer's training capacity. Additionally,
// the ith player can be matched with at most one trainer,
// and the jth trainer can be matched with at most one player.
// Return the maximum number of matchings
// between players and trainers that satisfy these conditions.

// Example 1:
// Input: players = [4,7,9], trainers = [8,2,5,8]
// Output: 2
// Explanation:
// One of the ways we can form two matchings is as follows:
// - players[0] can be matched with trainers[0] since 4 <= 8.
// - players[1] can be matched with trainers[3] since 7 <= 8.
// It can be proven that 2 is the maximum number
// of matchings that can be formed.

// Example 2:
// Input: players = [1,1,1], trainers = [10]
// Output: 1
// Explanation:
// The trainer can be matched with any of the 3 players.
// Each player can only be matched with one trainer,
// so the maximum answer is 1.

// Constraints:
//     1 <= players.length, trainers.length <= 105
//     1 <= players[i], trainers[j] <= 109

import 'testable.dart';

class Solution {
  int matchPlayersAndTrainers(List<int> players, List<int> trainers) {
    players.sort();
    trainers.sort();

    var result = 0;
    var traniersPointer = 0;

    for (
      var playersPointer = 0;
      playersPointer < players.length;
      playersPointer++
    ) {
      if (traniersPointer == trainers.length) return result;

      while (players[playersPointer] > trainers[traniersPointer]) {
        traniersPointer++;
        if (traniersPointer == trainers.length) return result;
      }

      traniersPointer++;
      result++;
    }

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({
    required this.players,
    required this.trainers,
    required super.result,
  });

  final List<int> players;
  final List<int> trainers;

  @override
  int computeResult() => Solution().matchPlayersAndTrainers(players, trainers);
}

void main(List<String> args) {
  [
    SolutionTest(players: [4, 7, 9], trainers: [8, 2, 5, 8], result: 2),
    SolutionTest(players: [1, 1, 1], trainers: [10], result: 1),
  ].test();
}
