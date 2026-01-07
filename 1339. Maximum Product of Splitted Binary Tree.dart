// Given the root of a binary tree, split the binary tree into two subtrees by removing one edge such that the product of the sums of the subtrees is maximized.
// Return the maximum product of the sums of the two subtrees. Since the answer may be too large, return it modulo 109 + 7.
// Note that you need to maximize the answer before taking the mod and not after taking it.
//
// Example 1:
// Input: root = [1,2,3,4,5,6]
// Output: 110
// Explanation: Remove the red edge and get 2 binary trees with sum 11 and 10. Their product is 110 (11*10)
//
// Example 2:
// Input: root = [1,null,2,3,4,null,null,5,6]
// Output: 90
// Explanation: Remove the red edge and get 2 binary trees with sum 15 and 6.Their product is 90 (15*6)
//
// Constraints:
// The number of nodes in the tree is in the range [2, 5 * 104].
// 1 <= Node.val <= 104

import 'tree_node.dart';
import 'testable.dart';

class Solution {
  int maxProduct(TreeNode? root) {
    if (root == null) return 0;

    final stack = <TreeNode>[];
    final sumStack = <int>[];
    TreeNode? curr = root;
    TreeNode? lastVisited;

    while (stack.isNotEmpty || curr != null) {
      while (curr != null) {
        stack.add(curr);
        curr = curr.left;
      }

      final peekNode = stack.last;

      if (peekNode.right != null && peekNode.right != lastVisited) {
        curr = peekNode.right;
      } else {
        final node = stack.removeLast();

        var leftSum = 0;
        var rightSum = 0;

        if (node.left != null) {
          leftSum = sumStack.removeLast();
        }

        if (node.right != null) {
          rightSum = sumStack.removeLast();
        }

        node.val = node.val + leftSum + rightSum;
        sumStack.add(node.val);

        lastVisited = node;
      }
    }

    final totalSum = root.val;
    var result = 0;

    final traversalStack = <TreeNode>[root];

    while (traversalStack.isNotEmpty) {
      final node = traversalStack.removeLast();

      final currentSum = node.val * (totalSum - node.val);
      result = result < currentSum ? currentSum : result;

      if (node.left != null) traversalStack.add(node.left!);
      if (node.right != null) traversalStack.add(node.right!);
    }

    return result % 1000000007;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().maxProduct(root);
}

void main(List<String> args) {
  [
    SolutionTest(root: TreeNode.fromList([1, 2, 3, 4, 5, 6]), result: 110),
    SolutionTest(
      root: TreeNode.fromList([1, null, 2, 3, 4, null, null, 5, 6]),
      result: 90,
    ),
  ].test();
}
