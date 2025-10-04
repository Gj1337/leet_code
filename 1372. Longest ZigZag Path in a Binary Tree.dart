// You are given the root of a binary tree.
// A ZigZag path for a binary tree is defined as follow:
//     Choose any node in the binary tree and a direction (right or left).
//     If the current direction is right, move to the right child of the current node; otherwise, move to the left child.
//     Change the direction from right to left or from left to right.
//     Repeat the second and third steps until you can't move in the tree.
// Zigzag length is defined as the number of nodes visited - 1. (A single node has a length of 0).
// Return the longest ZigZag path contained in that tree.

// Example 1:
// Input: root = [1,null,1,1,1,null,null,1,1,null,1,null,null,null,1]
// Output: 3
// Explanation: Longest ZigZag path in blue nodes (right -> left -> right).

// Example 2:
// Input: root = [1,1,1,null,1,null,null,1,1,null,1]
// Output: 4
// Explanation: Longest ZigZag path in blue nodes (left -> right -> left -> right).

// Example 3:
// Input: root = [1]
// Output: 0

// Constraints:
//     The number of nodes in the tree is in the range [1, 5 * 104].
//     1 <= Node.val <= 100

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  int longestZigZag(TreeNode? root) {
    var maxPath = 0;

    var stack = <(TreeNode?, bool, int)>[
      (root?.left, false, 1),
      (root?.right, true, 1),
    ];

    while (stack.isNotEmpty) {
      var (node, goLeft, zigZagPathLength) = stack.removeLast();

      if (node == null) continue;

      maxPath = zigZagPathLength > maxPath ? zigZagPathLength : maxPath;

      if (goLeft) {
        stack.add((node.left, false, zigZagPathLength + 1));
        stack.add((node.right, true, 1));
      } else {
        stack.add((node.right, true, zigZagPathLength + 1));
        stack.add((node.left, false, 1));
      }
    }

    return maxPath;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().longestZigZag(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, null, 1, 1, 1, null, null, null, 1]),
      result: 2,
    ),
    SolutionTest(
      root: TreeNode.fromList([
        1,
        null,
        1,
        1,
        1,
        null,
        null,
        1,
        1,
        null,
        1,
        null,
        null,
        null,
        1,
      ]),
      result: 3,
    ),
    SolutionTest(
      root: TreeNode.fromList([1, 1, 1, null, 1, null, null, 1, 1, null, 1]),
      result: 4,
    ),
    SolutionTest(root: TreeNode.fromList([1]), result: 0),
    SolutionTest(root: TreeNode.fromList([]), result: 0),
  ].test();
}
