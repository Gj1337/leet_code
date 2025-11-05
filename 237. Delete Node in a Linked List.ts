// There is a singly-linked list head and we want to delete a node node in it.
//
// You are given the node to be deleted node. You will not be given access to the first node of head.
//
// All the values of the linked list are unique, and it is guaranteed that the given node node is not the last node in the linked list.
//
// Delete the given node. Note that by deleting the node, we do not mean removing it from memory. We mean:
//
// The value of the given node should not exist in the linked list.
// The number of nodes in the linked list should decrease by one.
// All the values before node should be in the same order.
// All the values after node should be in the same order.
// Custom testing:
//
// For the input, you should provide the entire linked list head and the node to be given node. node should not be the last node of the list and should be an actual node in the list.
// We will build the linked list and pass the node to your function.
// The output will be the entire list after calling your function.
//
//
// Example 1:
// Input: head = [4,5,1,9], node = 5
// Output: [4,1,9]
// Explanation: You are given the second node with value 5, the linked list should become 4 -> 1 -> 9 after calling your function.
// Example 2:
// Input: head = [4,5,1,9], node = 1
// Output: [4,5,9]
// Explanation: You are given the third node with value 1, the linked list should become 4 -> 5 -> 9 after calling your function.
//
// Constraints:
// The number of the nodes in the given list is in the range [2, 1000].
// -1000 <= Node.val <= 1000
// The value of each node in the list is unique.
// The node to be deleted is in the list and is not a tail node.


class ListNode {
	val: number
	next: ListNode | null
	constructor(val?: number, next?: ListNode | null) {
		this.val = (val === undefined ? 0 : val)
		this.next = (next === undefined ? null : next)
	}
}

function deleteNode(node: ListNode | null): void {
	if (node != null) {
		let next = node.next;
		node.val = next!.val;
		node.next = next?.next ?? null;
	}

};

function createLinkedList(arr: number[]): ListNode | null {
	if (arr.length === 0) return null;
	const head = new ListNode(arr[0]);
	let current = head;
	for (let i = 1; i < arr.length; i++) {
		current.next = new ListNode(arr[i]);
		current = current.next;
	}
	return head;
}

function linkedListToArray(head: ListNode | null): number[] {
	const result: number[] = [];
	let current = head;
	while (current) {
		result.push(current.val);
		current = current.next;
	}
	return result;
}

function findNode(head: ListNode | null, value: number): ListNode | null {
	let current = head;
	while (current) {
		if (current.val === value) return current;
		current = current.next;
	}
	return null;
}

function assertEqual(actual: number[], expected: number[], testName: string) {
	const isEqual = actual.length === expected.length && actual.every((v, i) => v === expected[i]);
	const mark = isEqual ? "✅" : "❌";
	console.log(`${mark} ${testName}`);
	console.log("   Expected:", expected);
	console.log("   Got:     ", actual);
}

// ---- TEST CASES ----
function testDeleteNode() {
	let head1 = createLinkedList([4, 5, 1, 9]);
	let node1 = findNode(head1, 5);
	deleteNode(node1);
	assertEqual(linkedListToArray(head1), [4, 1, 9], "Test 1 (delete 5 from [4,5,1,9])");

	let head2 = createLinkedList([4, 5, 1, 9]);
	let node2 = findNode(head2, 1);
	deleteNode(node2);
	assertEqual(linkedListToArray(head2), [4, 5, 9], "Test 2 (delete 1 from [4,5,1,9])");
}

testDeleteNode();
