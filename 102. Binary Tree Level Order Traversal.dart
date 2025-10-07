// Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

// Example 1:
// Input: root = [3,9,20,null,null,15,7]
// Output: [[3],[9,20],[15,7]]

// Example 2:
// Input: root = [1]
// Output: [[1]]

// Example 3:
// Input: root = []
// Output: []

// Constraints:
//     The number of nodes in the tree is in the range [0, 2000].
//     -1000 <= Node.val <= 1000

import 'dart:collection';

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<List<int>> levelOrder(TreeNode? root) {
    var queue = Queue<TreeNode>();
    if (root != null) queue.add(root);
    final layers = <List<int>>[];

    while (queue.isNotEmpty) {
      final length = queue.length;
      final lvl = <int>[];

      for (var i = 0; i < length; i++) {
        final node = queue.removeFirst();
        lvl.add(node.val);
        queue.addAll([
          if (node.left != null) node.left!,
          if (node.right != null) node.right!,
        ]);
      }

      layers.add(lvl);
    }

    return layers;
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  List<List<int>> computeResult() => Solution().levelOrder(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 9, 20, null, null, 15, 7]),
      result: [
        [3],
        [9, 20],
        [15, 7],
      ],
    ),
    SolutionTest(
      root: TreeNode.fromList([1]),
      result: [
        [1],
      ],
    ),
    SolutionTest(root: TreeNode.fromList([]), result: []),
  ].test();
}
