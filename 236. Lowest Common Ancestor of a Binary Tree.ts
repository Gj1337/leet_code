// Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
// According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
//
// Example 1:
// Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
// Output: 3
// Explanation: The LCA of nodes 5 and 1 is 3.
//
// Example 2:
// Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
// Output: 5
// Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
//
// Example 3:
// Input: root = [1,2], p = 1, q = 2
// Output: 1
//
// Constraints:
//
//     The number of nodes in the tree is in the range [2, 105].
//     -109 <= Node.val <= 109
//     All Node.val are unique.
//     p != q
//     p and q will exist in the tree.

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

function lowestCommonAncestor(root: TreeNode | null, p: TreeNode | null, q: TreeNode | null): TreeNode | null {
	if (root === null || root === p || root === q) return root;

	var left = lowestCommonAncestor(root?.left ?? null, p, q);
	var right = lowestCommonAncestor(root?.right ?? null, p, q);

	if (left && right) return root;

	return left || right;
};

function buildTree(values: (number | null)[]): TreeNode | null {
	if (values.length === 0 || values[0] === null) return null;
	const root = new TreeNode(values[0]!);
	const queue: (TreeNode | null)[] = [root];
	let i = 1;
	while (i < values.length) {
		const node = queue.shift();
		if (node) {
			const leftVal = values[i++];
			if (leftVal !== undefined) {
				if (leftVal !== null) {
					node.left = new TreeNode(leftVal);
					queue.push(node.left);
				} else {
					node.left = null;
					queue.push(null);
				}
			}

			const rightVal = values[i++];
			if (rightVal !== undefined) {
				if (rightVal !== null) {
					node.right = new TreeNode(rightVal);
					queue.push(node.right);
				} else {
					node.right = null;
					queue.push(null);
				}
			}
		}
	}
	return root;
}

function findNode(root: TreeNode | null, val: number): TreeNode | null {
	if (!root) return null;
	if (root.val === val) return root;
	return findNode(root.left, val) || findNode(root.right, val);
}

// ---------------- TESTS ----------------
function test() {
	// Example 1
	let root = buildTree([3, 5, 1, 6, 2, 0, 8, null, null, 7, 4]);
	let p = findNode(root, 5);
	let q = findNode(root, 1);
	console.log("Example 1:", lowestCommonAncestor(root, p, q)?.val === 3);

	// Example 2
	root = buildTree([3, 5, 1, 6, 2, 0, 8, null, null, 7, 4]);
	p = findNode(root, 5);
	q = findNode(root, 4);
	console.log("Example 2:", lowestCommonAncestor(root, p, q)?.val === 5);

	// Example 3
	root = buildTree([1, 2]);
	p = findNode(root, 1);
	q = findNode(root, 2);
	console.log("Example 3:", lowestCommonAncestor(root, p, q)?.val === 1);
}

test();


