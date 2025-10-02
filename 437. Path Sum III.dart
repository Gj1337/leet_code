// Given the root of a binary tree and an integer targetSum,
// return the number of paths where the sum of the values along
// the path equals targetSum.
// The path does not need to start or end at the root or a leaf,
// but it must go downwards
//(i.e., traveling only from parent nodes to child nodes).

// Example 1:
// Input: root = [10,5,-3,3,2,null,11,3,-2,null,1], targetSum = 8
// Output: 3
// Explanation: The paths that sum to 8 are shown.

// Example 2:
// Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
// Output: 3

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  int pathSum(TreeNode? root, int targetSum) {
    final prefixSum = {0: 1};

    int traverse(TreeNode? root, int currentSum) {
      if (root == null) return 0;

      currentSum += root.val;
      var count = prefixSum[currentSum - targetSum] ?? 0;

      prefixSum[currentSum] = (prefixSum[currentSum] ?? 0) + 1;

      count += traverse(root.left, currentSum);
      count += traverse(root.right, currentSum);
      prefixSum[currentSum] = (prefixSum[currentSum] ?? 1) - 1;

      return count;
    }

    return traverse(root, 0);
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;
  final int targetSum;

  SolutionTest({
    required this.root,
    required this.targetSum,
    required super.result,
  });

  @override
  int computeResult() => Solution().pathSum(root, targetSum);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([10, 5, -3, 3, 2, null, 11, 3, -2, null, 1]),
      targetSum: 8,
      result: 3,
    ),
    SolutionTest(
      root: TreeNode.fromList([
        5,
        4,
        8,
        11,
        null,
        13,
        4,
        7,
        2,
        null,
        null,
        5,
        1,
      ]),
      targetSum: 22,
      result: 3,
    ),
  ].test();
}
