// Given the head of a linked list, return the node where the cycle begins.
// If there is no cycle, return null.
// There is a cycle in a linked list if there is some node in the list
// that can be reached again by continuously following the next pointer.
// Internally, pos is used to denote the index of the node that tail's
// next pointer is connected to (0-indexed). It is -1 if there is no cycle.
// Note that pos is not passed as a parameter.
// Do not modify the linked list.

// Example 1:
// Input: head = [3,2,0,-4], pos = 1
// Output: tail connects to node index 1
// Explanation: There is a cycle in the linked list,
// where tail connects to the second node.

// Example 2:
// Input: head = [1,2], pos = 0
// Output: tail connects to node index 0
// Explanation: There is a cycle in the linked list,
// where tail connects to the first node.

// Example 3:
// Input: head = [1], pos = -1
// Output: no cycle
// Explanation: There is no cycle in the linked list.

// Constraints:
//     The number of the nodes in the list is in the range [0, 104].
//     -105 <= Node.val <= 105
//     pos is -1 or a valid index in the linked-list.

function detectCycle(head: ListNode | null): ListNode | null {
    let slowPointer: ListNode | null = head;
    let quickPointer: ListNode | null = head;

    do {
        slowPointer = slowPointer?.next ?? null;
        quickPointer = quickPointer?.next?.next ?? null;

        if (quickPointer === null) return null;

    } while (slowPointer != quickPointer);

    while (head != slowPointer) {
        head = head!.next;
        slowPointer = slowPointer!.next;
    }

    return head;
};

//   Definition for singly-linked list.
class ListNode {
    val: number
    next: ListNode | null
    constructor(val?: number, next?: ListNode | null) {
        this.val = (val === undefined ? 0 : val)
        this.next = (next === undefined ? null : next)
    }
}

/**
 * Helper function to create a linked list with a cycle for testing.
 * @param vals An array of numbers to create the linked list nodes.
 * @param pos The index of the node where the cycle begins. Use -1 for no cycle.
 */
function createListWithCycle(vals: number[], pos: number): ListNode | null {
    if (vals.length === 0) {
        return null;
    }

    const nodes: ListNode[] = vals.map(val => new ListNode(val));
    for (let i = 0; i < nodes.length - 1; i++) {
        nodes[i].next = nodes[i + 1];
    }

    if (pos !== -1 && pos >= 0 && pos < nodes.length) {
        // Connect the tail to the node at `pos` to create the cycle
        nodes[nodes.length - 1].next = nodes[pos];
    }

    return nodes[0];
}


console.log("Running test cases for detectCycle...\n");

// Test Case 1: [3,2,0,-4], pos = 1
const head1 = createListWithCycle([3, 2, 0, -4], 1);
const cycleNode1 = detectCycle(head1);
const expectedVal1 = 2; // Node at index 1
const result1 = cycleNode1 ? `value: ${cycleNode1.val}` : "null";
const status1 = (cycleNode1?.val === expectedVal1) ? "✅ Passed" : "❌ Failed";
console.log(`Test Case 1: [3,2,0,-4], pos = 1`);
console.log(`Expected: cycle start at node with value ${expectedVal1}`);
console.log(`Received: cycle start at node with ${result1}`);
console.log(`Result: ${status1}\n`);

// Test Case 2: [1,2], pos = 0
const head2 = createListWithCycle([1, 2], 0);
const cycleNode2 = detectCycle(head2);
const expectedVal2 = 1; // Node at index 0
const result2 = cycleNode2 ? `value: ${cycleNode2.val}` : "null";
const status2 = (cycleNode2?.val === expectedVal2) ? "✅ Passed" : "❌ Failed";
console.log(`Test Case 2: [1,2], pos = 0`);
console.log(`Expected: cycle start at node with value ${expectedVal2}`);
console.log(`Received: cycle start at node with ${result2}`);
console.log(`Result: ${status2}\n`);

// Test Case 3: [1], pos = -1
const head3 = createListWithCycle([1], -1);
const cycleNode3 = detectCycle(head3);
const expectedVal3 = null;
const result3 = cycleNode3 ? `value: ${cycleNode3.val}` : "null";
const status3 = (cycleNode3 === expectedVal3) ? "✅ Passed" : "❌ Failed";
console.log(`Test Case 3: [1], pos = -1`);
console.log(`Expected: no cycle`);
console.log(`Received: ${result3}`);
console.log(`Result: ${status3}\n`);

// Test Case 4: empty list
const head4 = createListWithCycle([], -1);
const cycleNode4 = detectCycle(head4);
const expectedVal4 = null;
const result4 = cycleNode4 ? `value: ${cycleNode4.val}` : "null";
const status4 = (cycleNode4 === expectedVal4) ? "✅ Passed" : "❌ Failed";
console.log(`Test Case 4: Empty list`);
console.log(`Expected: no cycle`);
console.log(`Received: ${result4}`);
console.log(`Result: ${status4}\n`);
