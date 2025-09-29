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
