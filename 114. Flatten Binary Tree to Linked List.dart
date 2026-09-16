// Given the root of a binary tree, flatten the tree into a "linked list":
//
// The "linked list" should use the same TreeNode class where the right child pointer points to the next node in the list and the left child pointer is always null.
// The "linked list" should be in the same order as a pre-order traversal of the binary tree.
//
// Example 1:
// Input: root = [1,2,5,3,4,null,6]
// Output: [1,null,2,null,3,null,4,null,5,null,6]
//
// Example 2:
// Input: root = []
// Output: []
//
// Example 3:
// Input: root = [0]
// Output: [0]
//
// Constraints:
// The number of nodes in the tree is in the range [0, 2000].
// -100 <= Node.val <= 100
// Follow up: Can you flatten the tree in-place (with O(1) extra space)?

import 'tree_node.dart';
import 'testable.dart';

class Solution {
  void flatten(TreeNode? root) {
    while (root != null) {
      var temp = root.left;
      if (temp != null) {
        while (temp?.right != null) temp = temp?.right;
        temp?.right = root.right;
        root.right = root.left;
        root.left = null;
      }

      root = root.right;
    }
  }
}

// First try
// space complexity O(n)
//
// class Solution {
//   void flatten(TreeNode? root) {
//     if (root == null) return;
//
//     final leftBranch = root.left;
//     final rightBranch = root.right;
//     root.left = null;
//     root.right = null;
//     TreeNode? rightPointer = null;
//
//     void dfs(TreeNode? dfsRoot) {
//       if (dfsRoot == null) return;
//
//       final lastPointer = rightPointer ?? root;
//       lastPointer.right = TreeNode(dfsRoot.val);
//       rightPointer = lastPointer.right;
//
//       dfs(dfsRoot.left);
//       dfs(dfsRoot.right);
//     }
//
//     dfs(leftBranch);
//     dfs(rightBranch);
//   }
// }

class SolutionTest extends Testable<TreeNode?> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  bool validateResult(TreeNode? computedResult, TreeNode? expectedResult) =>
      TreeNode.isEqual(computedResult, expectedResult);

  @override
  TreeNode? computeResult() {
    Solution().flatten(this.root);

    return this.root;
  }
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, 2, 5, 3, 4, null, 6]),
      result: TreeNode.fromList([
        1,
        null,
        2,
        null,
        3,
        null,
        4,
        null,
        5,
        null,
        6,
      ]),
    ),
  ].test();
}
