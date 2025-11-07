// Given the root of a binary tree, return the preorder traversal of its nodes' values.
//
// Example 1:
// Input: root = [1,null,2,3]
// Output: [1,2,3]
//
// Example 2:
// Input: root = [1,2,3,4,5,null,8,null,null,6,7,9]
// Output: [1,2,4,5,6,7,3,8,9]
//
// Example 3:
// Input: root = []
// Output: []
//
// Example 4:
// Input: root = [1]
// Output: [1]
//
// Constraints:
//
// The number of nodes in the tree is in the range [0, 100].
// -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<int> preorderTraversal(TreeNode? root) {
    final result = <int>[];

    void dfs(TreeNode? root) {
      if (root == null) return;
      result.add(root.val);
      if (root.left != null) dfs(root.left);
      if (root.right != null) dfs(root.right);
    }

    dfs(root);

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  List<int> computeResult() => Solution().preorderTraversal(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, null, 2, 3]),
      result: [1, 2, 3],
    ),
    SolutionTest(
      root: TreeNode.fromList([1, 2, 3, 4, 5, null, 8, null, null, 6, 7, 9]),
      result: [1, 2, 4, 5, 6, 7, 3, 8, 9],
    ),
    SolutionTest(root: TreeNode.fromList([]), result: []),
    SolutionTest(root: TreeNode.fromList([1]), result: [1]),
  ].test();
}
