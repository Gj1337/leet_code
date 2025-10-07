// Given the root of a binary tree, imagine yourself standing on the right side of it,
// return the values of the nodes you can see ordered from top to bottom.

// Example 1:
// Input: root = [1,2,3,null,5,null,4]
// Output: [1,3,4]
// Explanation:

// Example 2:
// Input: root = [1,2,3,4,null,null,null,5]
// Output: [1,3,4,5]
// Explanation:

// Example 3:
// Input: root = [1,null,3]
// Output: [1,3]

// Example 4:
// Input: root = []
// Output: []

// Constraints:
//     The number of nodes in the tree is in the range [0, 100].
//     -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<int> rightSideView(TreeNode? root) {
    final result = <int>[];

    void traverse(TreeNode? root, int lvl) {
      if (root == null) return;

      if (result.length <= lvl) {
        result.add(root.val);
      }

      traverse(root.right, lvl + 1);
      traverse(root.left, lvl + 1);
    }

    traverse(root, 0);

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  List<int> computeResult() => Solution().rightSideView(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, 2, 3, null, 5, null, 4]),
      result: [1, 3, 4],
    ),
    SolutionTest(
      root: TreeNode.fromList([1, 2, 3, 4, null, null, null, 5]),
      result: [1, 3, 4, 5],
    ),
    SolutionTest(root: TreeNode.fromList([1, null, 3]), result: [1, 3]),
    SolutionTest(root: TreeNode.fromList([]), result: []),
  ].test();
}
