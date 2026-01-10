import 'dart:collection';

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);

  static TreeNode? fromList(List<int?> values) {
    if (values.isEmpty || values[0] == null) return null;

    final root = TreeNode(values[0]!);
    final queue = Queue<TreeNode>()..add(root);
    var i = 1;

    while (i < values.length && queue.isNotEmpty) {
      final node = queue.removeFirst();

      if (i < values.length && values[i] != null) {
        final leftNode = TreeNode(values[i]!);
        node.left = leftNode;
        queue.add(leftNode);
      }
      i++;

      if (i < values.length && values[i] != null) {
        final rightNode = TreeNode(values[i]!);
        node.right = rightNode;
        queue.add(rightNode);
      }
      i++;
    }

    return root;
  }

  static bool isEqual(TreeNode? t1, TreeNode? t2) {
    // 1. If both are null, they are equal
    if (t1 == null && t2 == null) return true;

    // 2. If one is null and the other isn't, they aren't equal
    if (t1 == null || t2 == null) return false;

    // 3. Check current value and recurse for children
    return t1.val == t2.val &&
        isEqual(t1.left, t2.left) &&
        isEqual(t1.right, t2.right);
  }

  String prettyString([String prefix = "", bool isLeft = true]) {
    final buffer = StringBuffer();

    if (right != null) {
      buffer.write(
        right!.prettyString("$prefix${isLeft ? "│   " : "    "}", false),
      );
    }

    buffer.writeln("$prefix${isLeft ? "└── " : "┌── "}$val");

    if (left != null) {
      buffer.write(
        left!.prettyString("$prefix${isLeft ? "    " : "│   "}", true),
      );
    }

    return buffer.toString();
  }

  @override
  String toString() => prettyString();
}
