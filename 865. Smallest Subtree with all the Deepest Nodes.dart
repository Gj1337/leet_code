// Given the root of a binary tree, the depth of each node is the shortest distance to the root.
// Return the smallest subtree such that it contains all the deepest nodes in the original tree.
// A node is called the deepest if it has the largest depth possible among any node in the entire tree.
// The subtree of a node is a tree consisting of that node, plus the set of all descendants of that node.
//
// Example 1:
// Input: root = [3,5,1,6,2,0,8,null,null,7,4]
// Output: [2,7,4]
// Explanation: We return the node with value 2, colored in yellow in the diagram.
// The nodes coloured in blue are the deepest nodes of the tree.
// Notice that nodes 5, 3 and 2 contain the deepest nodes in the tree but node 2 is the smallest subtree among them, so we return it.
//
// Example 2:
// Input: root = [1]
// Output: [1]
// Explanation: The root is the deepest node in the tree.
//
// Example 3:
// Input: root = [0,1,3,null,2]
// Output: [2]
// Explanation: The deepest node in the tree is 2, the valid subtrees are the subtrees of nodes 2, 1 and 0 but the subtree of node 2 is the smallest.
//
// Constraints:
// The number of nodes in the tree will be in the range [1, 500].
// 0 <= Node.val <= 500
// The values of the nodes in the tree are unique.

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  TreeNode? subtreeWithAllDeepest(TreeNode? root) {
    ({TreeNode? node, int dist}) dfs(TreeNode? node) {
      if (node == null) return (node: node, dist: 0);

      final left = dfs(node.left);
      final right = dfs(node.right);

      if (left.dist > right.dist) return (node: left.node, dist: left.dist + 1);
      if (left.dist < right.dist)
        return (node: right.node, dist: right.dist + 1);

      return (node: node, dist: left.dist + 1);
    }

    return dfs(root).node;
  }
}

class SolutionTest extends Testable<TreeNode?> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  bool validateResult(TreeNode? computedResult, TreeNode? expectedResult) {
    print(computedResult.hashCode);
    print(computedResult.toString());
    print('');
    print(expectedResult.hashCode);
    print(expectedResult.toString());

    return TreeNode.isEqual(computedResult, expectedResult);
  }

  @override
  computeResult() => Solution().subtreeWithAllDeepest(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([3, 5, 1, 6, 2, 0, 8, null, null, 7, 4]),
      result: TreeNode.fromList([2, 7, 4]),
    ),
    SolutionTest(root: TreeNode.fromList([1]), result: TreeNode.fromList([1])),
    SolutionTest(
      root: TreeNode.fromList([0, 1, 3, null, 2]),
      result: TreeNode.fromList([2]),
    ),
  ].test();
}
