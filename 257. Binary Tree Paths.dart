// Given the root of a binary tree, return all root-to-leaf paths in any order.
// A leaf is a node with no children.
//
// Example 1:
// Input: root = [1,2,3,null,5]
// Output: ["1->2->5","1->3"]
//
// Example 2:
// Input: root = [1]
// Output: ["1"]
//
// Constraints:
//
// The number of nodes in the tree is in the range [1, 100].
// -100 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<String> binaryTreePaths(TreeNode? root) {
    final result = <String>[];

    void dfs(TreeNode? root, [String path = '']) {
      if (root == null) return;

      path = path + root.val.toString();

      if (root.left == null && root.right == null) {
        result.add(path.toString());
        return;
      }

      dfs(root.left, path + '->');
      dfs(root.right, path + '->');
    }

    dfs(root);

    return result;
  }
}

class SolutionTest extends Testable<List<String>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({
    required this.root,
    required super.result,
  });

  @override
  List<String> computeResult() => Solution().binaryTreePaths(root);

  @override
  bool validateResult(
      List<String> computedResult, List<String> expectedResult) {
    computedResult.sort();
    expectedResult.sort();

    return super.validateResult(computedResult, expectedResult);
  }
}

void main(List<String> args) {
  [
    SolutionTest(
        root: TreeNode.fromList([1, 2, 3, null, 5]),
        result: ["1->2->5", "1->3"]),
    SolutionTest(root: TreeNode.fromList([1]), result: ["1"]),
  ].test();
}
