// Consider all the leaves of a binary tree, from left to right order,
// the values of those leaves form a leaf value sequence.
// For example, in the given tree above,
// the leaf value sequence is (6, 7, 4, 9, 8).
// Two binary trees are considered leaf-similar
// if their leaf value sequence is the same.
// Return true if and only if the two given trees
//with head nodes root1 and root2 are leaf-similar.

// Example 1:
// Input: root1 = [3,5,1,6,2,9,8,null,null,7,4],
// root2 = [3,5,1,6,7,4,2,null,null,null,null,null,null,9,8]
// Output: true

// Example 2:
// Input: root1 = [1,2,3], root2 = [1,3,2]
// Output: false

// Constraints:
//     The number of nodes in each tree will be in the range [1, 200].
//     Both of the given trees will have values in the range [0, 200].

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  bool leafSimilar(TreeNode? root1, TreeNode? root2) {
    List<int> getLeafs(TreeNode? root) {
      final result = <int>[];
      if (root == null) return result;

      void getLeafValue(TreeNode root) {
        final (left, right) = (root.left, root.right);

        if (left != null) {
          getLeafValue(left);
        }

        if (right != null) {
          getLeafValue(right);
        }

        if (right == null && left == null) {
          result.add(root.val);
        }
      }

      getLeafValue(root);

      return result;
    }

    final leaves1 = getLeafs(root1);
    final leaves2 = getLeafs(root2);

    if (leaves1.length != leaves2.length) {
      return false;
    }

    for (var i = 0; i < leaves1.length; i++) {
      if (leaves1[i] != leaves2[i]) return false;
    }

    return true;
  }
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final TreeNode? root1;
  final TreeNode? root2;

  SolutionTest({
    required this.root1,
    required this.root2,
    required super.result,
  });

  @override
  bool computeResult() => Solution().leafSimilar(root1, root2);
}

void main(List<String> args) {
  [
    SolutionTest(
      root1: TreeNode.fromList([3, 5, 1, 6, 2, 9, 8, null, null, 7, 4]),
      root2: TreeNode.fromList([
        3,
        5,
        1,
        6,
        7,
        4,
        2,
        null,
        null,
        null,
        null,
        null,
        null,
        9,
        8,
      ]),
      result: true,
    ),
    SolutionTest(
      root1: TreeNode.fromList([1, 2, 3]),
      root2: TreeNode.fromList([1, 3, 2]),
      result: false,
    ),
  ].test();
}
