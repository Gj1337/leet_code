// Given the root of a binary tree and an integer targetSum, return all root-to-leaf paths where the sum of the node values in the path equals targetSum. Each path should be returned as a list of the node values, not node references.
// A root-to-leaf path is a path starting from the root and ending at any leaf node. A leaf is a node with no children.

// Example 1:
// Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
// Output: [[5,4,11,2],[5,8,4,5]]
// Explanation: There are two paths whose sum equals targetSum:
// 5 + 4 + 11 + 2 = 22
// 5 + 8 + 4 + 5 = 22

// Example 2:
// Input: root = [1,2,3], targetSum = 5
// Output: []

// Example 3:
// Input: root = [1,2], targetSum = 0
// Output: []

// Constraints:
//     The number of nodes in the tree is in the range [0, 5000].
//     -1000 <= Node.val <= 1000
//     -1000 <= targetSum <= 1000

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<List<int>> pathSum(TreeNode? root, int targetSum) {
    final results = <List<int>>[];

    void traverse(TreeNode? root, int currentSum, List<int> nodes) {
      if (root == null) return;

      currentSum += root.val;
      nodes.add(root.val);

      if (root.left == null && root.right == null && currentSum == targetSum) {
        results.add([...nodes]);
      }

      traverse(root.left, currentSum, nodes);
      traverse(root.right, currentSum, nodes);

      nodes.removeLast();
    }

    traverse(root, 0, []);
    return results;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final TreeNode? root;
  final int targetSum;

  SolutionTest({
    required this.root,
    required this.targetSum,
    required super.result,
  });

  @override
  List<List<int>> computeResult() => Solution().pathSum(root, targetSum);
}

void main(List<String> args) {
  [
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
      result: [
        [5, 4, 11, 2],
        [5, 8, 4, 5],
      ],
    ),
    SolutionTest(root: TreeNode.fromList([1, 2, 3]), targetSum: 5, result: []),
  ].test();
}
