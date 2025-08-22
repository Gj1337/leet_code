class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);

  static ListNode? fromList(List<int> list) {
    if (list.isEmpty) return null;

    final head = ListNode(list.first);
    ListNode? current = head;
    for (int i = 1; i < list.length; i++) {
      current?.next = ListNode(list[i]);
      current = current?.next;
    }
    return head;
  }

  List<int> toList() {
    final result = <int>[];
    ListNode? current = this;
    while (current != null) {
      result.add(current.val);
      current = current.next;
    }
    return result;
  }

  @override
  String toString() => this.toList().toString();
}
