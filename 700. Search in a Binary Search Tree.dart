// You are given the root of a binary search tree (BST) and an integer val.
// Find the node in the BST that the node's value equals val and return the subtree rooted with that node. If such a node does not exist, return null.
//
// Example 1:
// Input: root = [4,2,7,1,3], val = 2
// Output: [2,1,3]
//
// Example 2:
// Input: root = [4,2,7,1,3], val = 5
// Output: []
//
// Constraints:
//     The number of nodes in the tree is in the range [1, 5000].
//     1 <= Node.val <= 107
//     root is a binary search tree.
//     1 <= val <= 107
import 'dart:collection';

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  TreeNode? searchBST(TreeNode? root, int val) {
    final queue = Queue<TreeNode>();
    if (root != null) queue.add(root);

    while (queue.isNotEmpty) {
      final node = queue.removeFirst();

      if (node.val == val) return node;

      queue.addAll([
        if (node.left != null) node.left!,
        if (node.right != null) node.right!,
      ]);
    }

    return null;
  }
}

class SolutionTest extends Testable<TreeNode?> with ConsoleTestOutput {
  final TreeNode? root;
  final int val;

  SolutionTest({required this.root, required this.val, required super.result});

  @override
  TreeNode? computeResult() => Solution().searchBST(root, val);

  @override
  bool validateResult(TreeNode? computedResult, TreeNode? expectedResult) =>
      computedResult.toString() == expectedResult.toString();
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([4, 2, 7, 1, 3]),
      val: 2,
      result: TreeNode.fromList([2, 1, 3]),
    ),
    SolutionTest(
      root: TreeNode.fromList([4, 2, 7, 1, 3]),
      val: 5,
      result: TreeNode.fromList([]),
    ),
  ].test();
}
