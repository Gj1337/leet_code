// Given the root of a binary tree, return the bottom-up level order traversal of its nodes' values. (i.e., from left to right, level by level from leaf to root).
//
// Example 1:
// Input: root = [3,9,20,null,null,15,7]
// Output: [[15,7],[9,20],[3]]
//
// Example 2:
// Input: root = [1]
// Output: [[1]]
//
// Example 3:
// Input: root = []
// Output: []
//
// Constraints:
// The number of nodes in the tree is in the range [0, 2000].
// -1000 <= Node.val <= 1000

import 'tree_node.dart';
import 'testable.dart';

import 'dart:collection';

class Solution {
  List<List<int>> levelOrderBottom(TreeNode? root) {
    final queue = Queue<TreeNode?>()..add(root);
    final reversedResult = <List<int>>[];

    while (queue.isNotEmpty) {
      final queueLength = queue.length;
      final currentList = <int>[];

      for (var i = 0; i < queueLength; i++) {
        final element = queue.removeFirst();

        if (element == null) continue;

        currentList.add(element.val);
        queue.add(element.left);
        queue.add(element.right);
      }

      if (currentList.isNotEmpty) reversedResult.add(currentList);
    }

    return reversedResult.reversed.toList();
  }
}

class SolutionTest extends Testable<List<List<int>>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  List<List<int>> computeResult() => Solution().levelOrderBottom(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 9, 20, null, null, 15, 7]),
      result: [
        [15, 7],
        [9, 20],
        [3],
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
