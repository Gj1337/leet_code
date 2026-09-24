// Given the root of a binary tree, return the sum of all left leaves.
// A leaf is a node with no children. A left leaf is a leaf that is the left child of another node.
//
// Example 1:
// Input: root = [3,9,20,null,null,15,7]
// Output: 24
// Explanation: There are two left leaves in the binary tree, with values 9 and 15 respectively.
//
// Example 2:
// Input: root = [1]
// Output: 0
//
// Constraints:
// The number of nodes in the tree is in the range [1, 1000].
// -1000 <= Node.val <= 1000

import 'tree_node.dart';
import 'testable.dart';

class Solution {
  int sumOfLeftLeaves(TreeNode? root) {
    var result = 0;

    void dfs(TreeNode? root) {
      if (root == null) return;
      if (root.left != null &&
          root.left?.left == null &&
          root.left?.right == null) {
        result += root.left!.val;
      } else {
        dfs(root.left);
      }

      dfs(root.right);
    }

    dfs(root);

    return result;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().sumOfLeftLeaves(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 9, 20, null, null, 15, 7]),
      result: 24,
    ),
    SolutionTest(root: TreeNode.fromList([]), result: 0),
  ].test();
}
