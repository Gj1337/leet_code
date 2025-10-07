// Given the root of a binary tree, the level of its root is 1, the level of its children is 2, and so on.
// Return the smallest level x such that the sum of all the values of nodes at level x is maximal.

// Example 1:
// Input: root = [1,7,0,7,-8,null,null]
// Output: 2
// Explanation:
// Level 1 sum = 1.
// Level 2 sum = 7 + 0 = 7.
// Level 3 sum = 7 + -8 = -1.
// So we return the level with the maximum sum which is level 2.

// Example 2:
// Input: root = [989,null,10250,98693,-89388,null,null,null,-32127]
// Output: 2

// Constraints:
//     The number of nodes in the tree is in the range [1, 104].
//     -105 <= Node.val <= 105

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  int maxLevelSum(TreeNode? root) {
    final sumList = <int>[];

    void traverse(TreeNode? root, int lvl) {
      if (root == null) return;

      sumList.length <= lvl ? sumList.add(root.val) : sumList[lvl] += root.val;

      traverse(root.left, lvl + 1);
      traverse(root.right, lvl + 1);
    }

    traverse(root, 0);

    var indexOfMax = 0;
    for (var i = 0; i < sumList.length; i++) {
      if (sumList[i] > sumList[indexOfMax]) indexOfMax = i;
    }

    return indexOfMax + 1;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  int computeResult() => Solution().maxLevelSum(root);
}

void main(List<String> args) {
  [
    SolutionTest(
      root: TreeNode.fromList([1, 7, 0, 7, -8, null, null]),
      result: 2,
    ),
    SolutionTest(
      root: TreeNode.fromList([
        989,
        null,
        10250,
        98693,
        -89388,
        null,
        null,
        null,
        -32127,
      ]),
      result: 2,
    ),
  ].test();
}
