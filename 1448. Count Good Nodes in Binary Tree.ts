// Given a binary tree root, a node X in the tree is named good
// if in the path from root to X there are no nodes with a value greater than X.
// Return the number of good nodes in the binary tree.

// Example 1:
// Input: root = [3,1,4,3,null,1,5]
// Output: 4
// Explanation: Nodes in blue are good.
// Root Node (3) is always a good node.
// Node 4 -> (3,4) is the maximum value in the path starting from the root.
// Node 5 -> (3,4,5) is the maximum value in the path
// Node 3 -> (3,1,3) is the maximum value in the path.

// Example 2:
// Input: root = [3,3,null,4,2]
// Output: 3
// Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.

// Example 3:
// Input: root = [1]
// Output: 1
// Explanation: Root is considered as good.

// Constraints:
//     The number of nodes in the binary tree is in the range [1, 10^5].
//     Each node's value is between [-10^4, 10^4].

class TreeNode {
    val: number
    left: TreeNode | null
    right: TreeNode | null
    constructor(val?: number, left?: TreeNode | null, right?: TreeNode | null) {
        this.val = (val === undefined ? 0 : val)
        this.left = (left === undefined ? null : left)
        this.right = (right === undefined ? null : right)
    }
}

function goodNodes(root: TreeNode | null): number {
    let count = 0;

    function traverse(root: TreeNode | null, maxValue: number) {
        if (root == null) return;
        if (root.val >= maxValue) {
            count++;
            maxValue = root.val;
        }

        traverse(root.left, maxValue);
        traverse(root.right, maxValue);
    }

    traverse(root, root?.val ?? 0);

    return count;
};

function buildTree(arr: (number | null)[]): TreeNode | null {
    if (arr.length === 0) return null;
    const root = new TreeNode(arr[0]!);
    const queue: TreeNode[] = [root];
    let i = 1;

    while (queue.length > 0 && i < arr.length) {
        const current = queue.shift()!;

        if (i < arr.length && arr[i] !== null) {
            current.left = new TreeNode(arr[i]!);
            queue.push(current.left);
        }
        i++;

        if (i < arr.length && arr[i] !== null) {
            current.right = new TreeNode(arr[i]!);
            queue.push(current.right);
        }
        i++;
    }

    return root;
}


function main() {
    const examples: { input: (number | null)[], expected: number }[] = [
        { input: [3, 1, 4, 3, null, 1, 5], expected: 4 },
        { input: [3, 3, null, 4, 2], expected: 3 },
        { input: [1], expected: 1 },
    ];

    examples.forEach((ex, idx) => {
        const tree = buildTree(ex.input);
        const result = goodNodes(tree);
        console.log(`Example ${idx + 1}: got = ${result}, expected = ${ex.expected}. ${result === ex.expected ? '✅' : '❌'}`);
    });
}

main();
