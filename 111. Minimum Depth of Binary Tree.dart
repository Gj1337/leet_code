// Given a binary tree, find its minimum depth.
// The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
// Note: A leaf is a node with no children.
//
// Example 1:
// Input: root = [3,9,20,null,null,15,7]
// Output: 2
//
// Example 2:
// Input: root = [2,null,3,null,4,null,5,null,6]
// Output: 5
//
// Constraints:
//     The number of nodes in the tree is in the range [0, 105].
//     -1000 <= Node.val <= 1000

import 'tree_node.dart';
import 'testable.dart';
import 'dart:collection';

class Solution {
  int minDepth(TreeNode? root) {
    final queue = Queue<TreeNode>();
    if (root != null) queue.add(root);
    var depth = 0;

    while (queue.isNotEmpty) {
      depth++;
      final queueLength = queue.length;

      for (var i = 0; i < queueLength; i++) {
        final node = queue.removeFirst();
        if (node.left == null && node.right == null) return depth;

        queue.addAll([
          if (node.left != null) node.left!,
          if (node.right != null) node.right!,
        ]);
      }
    }

    return depth;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().minDepth(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 9, 20, null, null, 15, 7]),
      result: 2,
    ),
    SolutionTest(
      root: TreeNode.fromList([2, null, 3, null, 4, null, 5, null, 6]),
      result: 5,
    ),
  ].test();
}
