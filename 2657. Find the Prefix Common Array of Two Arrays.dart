// You are given two 0-indexed integer permutations A and B of length n.
//
// A prefix common array of A and B is an array C such that C[i] is equal to the count of numbers that are present at or before the index i in both A and B.
//
// Return the prefix common array of A and B.
//
// A sequence of n integers is called a permutation if it contains all integers from 1 to n exactly once.
//
// Example 1:
// Input: A = [1,3,2,4], B = [3,1,2,4]
// Output: [0,2,3,4]
// Explanation: At i = 0: no number is common, so C[0] = 0.
// At i = 1: 1 and 3 are common in A and B, so C[1] = 2.
// At i = 2: 1, 2, and 3 are common in A and B, so C[2] = 3.
// At i = 3: 1, 2, 3, and 4 are common in A and B, so C[3] = 4.
//
// Example 2:
// Input: A = [2,3,1], B = [3,1,2]
// Output: [0,1,3]
// Explanation: At i = 0: no number is common, so C[0] = 0.
// At i = 1: only 3 is common in A and B, so C[1] = 1.
// At i = 2: 1, 2, and 3 are common in A and B, so C[2] = 3.
//
// Constraints:
//     1 <= A.length == B.length == n <= 50
//     1 <= A[i], B[i] <= n
//     It is guaranteed that A and B are both a permutation of n integers.

import 'testable.dart';

class Solution {
  List<int> findThePrefixCommonArray(List<int> A, List<int> B) {
    final aLetters = <int>{};
    final bLetters = <int>{};
    final commonLetters = <int>{};
    final result = List<int>.filled(A.length, 9);
    var commonLettersCouter = 0;

    for (var i = 0; i < A.length; i++) {
      aLetters.add(A[i]);
      bLetters.add(B[i]);

      if (bLetters.contains(A[i]) && !commonLetters.contains(A[i])) {
        commonLettersCouter++;
        commonLetters.add(A[i]);
      }

      if (aLetters.contains(B[i]) && !commonLetters.contains(B[i])) {
        commonLettersCouter++;
        commonLetters.add(B[i]);
      }

      result[i] = commonLettersCouter;
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final List<int> A, B;

  SolutionTest({required this.A, required this.B, required super.result});

  @override
  List<int> computeResult() => Solution().findThePrefixCommonArray(A, B);
}

void main(List<String> args) {
  [
    SolutionTest(A: [1, 3, 2, 4], B: [3, 1, 2, 4], result: [0, 2, 3, 4]),
    SolutionTest(A: [2, 3, 1], B: [3, 1, 2], result: [0, 1, 3]),
  ].test();
}
