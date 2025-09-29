// Given the root of a binary tree, return its maximum depth.
// A binary tree's maximum depth is the number of nodes
// along the longest path from the root node down to the farthest leaf node.
//
// Example 1:
// Input: root = [3,9,20,null,null,15,7]
// Output: 3
//
// Example 2:
// Input: root = [1,null,2]
// Output: 2
//
// Constraints:
//     The number of nodes in the tree is in the range [0, 104].
//     -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  int maxDepth(TreeNode? root) {
    var maxDepth = 0;

    void traverceDeep(TreeNode? treeNode, [int currentDepth = 0]) {
      if (treeNode == null) {
        maxDepth = maxDepth > currentDepth ? maxDepth : currentDepth;
        return;
      }

      traverceDeep(treeNode.left, currentDepth + 1);
      traverceDeep(treeNode.right, currentDepth + 1);
    }

    traverceDeep(root);

    return maxDepth;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().maxDepth(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 9, 20, null, null, 15, 7]),
      result: 3,
    ),
    SolutionTest(root: TreeNode.fromList([1, null, 2]), result: 2),
  ].test();
}
