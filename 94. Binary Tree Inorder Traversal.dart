class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Solution {
  List<int> inorderTraversal(TreeNode? root) {
    final result = <int>[];
    if (root == null) return result;

    var current = root;

    if (current.left != null) {
      result.addAll(inorderTraversal(current.left));
    }

    result.add(current.val);

    if (current.right != null) {
      result.addAll(inorderTraversal(current.right));
    }

    return result;
  }
}
