// Given the root of a binary tree, invert the tree, and return its root.
//
// Example 1:
// Input: root = [4,2,7,1,3,6,9]
// Output: [4,7,2,9,6,3,1]
// Example 2:
//
// Input: root = [2,1,3]
// Output: [2,3,1]
//
// Example 3:
// Input: root = []
// Output: []
//
// Constraints:
// The number of nodes in the tree is in the range [0, 100].
// -100 <= Node.val <= 100

import 'tree_node.dart';
import 'testable.dart';

class Solution {
  TreeNode? invertTree(TreeNode? root) {
    void iterate(TreeNode? root) {
      if (root == null) return;

      var temp = root.left;
      root.left = root.right;
      root.right = temp;

      iterate(root.left);
      iterate(root.right);
    }

    iterate(root);

    return root;
  }
}

class SolutionTest extends Testable<TreeNode?> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  bool validateResult(TreeNode? computedResult, TreeNode? expectedResult) =>
      TreeNode.isEqual(computedResult, expectedResult);

  @override
  TreeNode? computeResult() => Solution().invertTree(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([4, 2, 7, 1, 3, 6, 9]),
      result: TreeNode.fromList([4, 7, 2, 9, 6, 3, 1]),
    ),
    SolutionTest(
      root: TreeNode.fromList([2, 1, 3]),
      result: TreeNode.fromList([2, 3, 1]),
    ),
    SolutionTest(root: TreeNode.fromList([]), result: TreeNode.fromList([])),
  ].test();
}
