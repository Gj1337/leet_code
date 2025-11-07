// Given the root of a binary tree, check whether it is a mirror of itself (i.e., symmetric around its center).
//
// Example 1:
// Input: root = [1,2,2,3,4,4,3]
// Output: true
//
// Example 2:
// Input: root = [1,2,2,null,3,null,3]
// Output: false
//
// Constraints:
// The number of nodes in the tree is in the range [1, 1000].
// -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  bool isSymmetric(TreeNode? root) {
    bool isMirror(TreeNode? left, TreeNode? right) {
      if (right == null && left == null) return true;
      if (right == null || left == null) return false;
      return left.val == right.val &&
          isMirror(left.left, right.right) &&
          isMirror(left.right, right.left);
    }

    return root != null ? isMirror(root.left, root.right) : false;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  bool computeResult() => Solution().isSymmetric(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, 2, 2, 3, 4, 4, 3]),
      result: true,
    ),
    SolutionTest(
      root: TreeNode.fromList([1, 2, 2, null, 3, null, 3]),
      result: false,
    ),
  ].test();
}
