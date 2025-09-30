// Given the root of a binary tree, return the most frequent subtree sum.
// If there is a tie, return all the values with the highest frequency in any order.
// The subtree sum of a node is defined as the sum of all the node values
// formed by the subtree rooted at that node (including the node itself).

// Example 1:
// Input: root = [5,2,-3]
// Output: [2,-3,4]

// Example 2:
// Input: root = [5,2,-5]
// Output: [2]

// Constraints:
//     The number of nodes in the tree is in the range [1, 104].
//     -105 <= Node.val <= 105

import 'testable.dart';
import 'tree_node.dart';

class Solution {
  List<int> findFrequentTreeSum(TreeNode? root) {
    final sumFreq = <int, int>{};

    int getSum(TreeNode? root) {
      if (root == null) return 0;

      final leftSum = getSum(root.left);
      final rightSum = getSum(root.right);

      final sum = root.val + leftSum + rightSum;

      sumFreq[sum] = (sumFreq[sum] ?? 0) + 1;

      return sum;
    }

    getSum(root);

    var result = <int>[];

    for (var num in sumFreq.keys) {
      final maxFreq = sumFreq[result.lastOrNull] ?? 0;

      switch (sumFreq[num]!) {
        case (final currentFreq) when currentFreq == maxFreq:
          result.add(num);
        case (final currentFreq) when currentFreq > maxFreq:
          result = [num];
      }
    }

    return result;
  }
}

class SolutionTest extends Testable<List<int>> with ConsoleTestOutput {
  final TreeNode? root;

  SolutionTest({required this.root, required super.result});

  @override
  List<int> computeResult() => Solution().findFrequentTreeSum(root);
}

void main(List<String> args) {
  [
    SolutionTest(root: TreeNode.fromList([5, 2, -3]), result: [2, -3, 4]),
    SolutionTest(root: TreeNode.fromList([5, 2, -5]), result: [2]),
  ].test();
}
