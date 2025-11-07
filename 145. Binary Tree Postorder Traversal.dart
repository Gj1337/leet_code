// Given the root of a binary tree, return the postorder traversal of its nodes' values.
//
// Example 1:
// Input: root = [1,null,2,3]
// Output: [3,2,1]
//
// Example 2:
// Input: root = [1,2,3,4,5,null,8,null,null,6,7,9]
// Output: [4,6,7,5,2,9,8,3,1]
//
// Example 3:
// Input: root = []
// Output: []

// Example 4:
// Input: root = [1]
// Output: [1]
//
// Constraints:
//
// The number of the nodes in the tree is in the range [0, 100].
// -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<int> postorderTraversal(TreeNode? root) {
    final result = <int>[];

    void dfs(TreeNode? root) {
      if (root == null) return;
      if (root.left != null) dfs(root.left);
      if (root.right != null) dfs(root.right);

      result.add(root.val);
    }

    dfs(root);

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({
    required this.root,
    required super.result,
  });

  @override
  List<int> computeResult() => Solution().postorderTraversal(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, null, 2, 3]),
      result: [3, 2, 1],
    ),
    SolutionTest(
        root: TreeNode.fromList([1, 2, 3, 4, 5, null, 8, null, null, 6, 7, 9]),
        result: [4, 6, 7, 5, 2, 9, 8, 3, 1]),
    SolutionTest(
      root: TreeNode.fromList([1]),
      result: [1],
    ),
    SolutionTest(
      root: TreeNode.fromList([]),
      result: [],
    ),
  ].test();
}
