// You are given an integer array nums and an integer k.
// In one operation, you can pick two numbers
//  from the array whose sum equals k and remove them from the array.
// Return the maximum number of operations you can perform on the array.

// Example 1:
// Input: nums = [1,2,3,4], k = 5
// Output: 2
// Explanation: Starting with nums = [1,2,3,4]:
// - Remove numbers 1 and 4, then nums = [2,3]
// - Remove numbers 2 and 3, then nums = []
// There are no more pairs that sum up to 5, hence a total of 2 operations.

// Example 2:
// Input: nums = [3,1,3,4,3], k = 6
// Output: 1
// Explanation: Starting with nums = [3,1,3,4,3]:
// - Remove the first two 3's, then nums = [1,4,3]
// There are no more pairs that sum up to 6, hence a total of 1 operation.

// Constraints:
//     1 <= nums.length <= 105
//     1 <= nums[i] <= 109
//     1 <= k <= 109
function maxOperations(nums: number[], k: number): number {
    let result = 0;
    let freq = new Map<number, number>();

    for (const num of nums) {
        const searchableNumber = k - num;

        if (freq[searchableNumber] > 0) {
            freq[searchableNumber] = freq[searchableNumber] - 1;
            result++;
        }
        else {
            freq[num] = (freq[num] ?? 0) + 1;
        }
    }


    return result;
}

function maxOperationsBySorting(nums: number[], k: number): number {
    nums.sort((a, b) => a - b);

    let result = 0;
    let firstPointer = 0;
    let lastPointer = nums.length - 1;

    while (firstPointer < lastPointer) {
        let sum = nums[firstPointer] + nums[lastPointer];

        if (sum == k) {
            result++;
            firstPointer++;
            lastPointer--;
        }
        else if (sum > k) {
            lastPointer--;
        }
        else {
            firstPointer++;
        }
    }

    return result;
};

[
    { nums: [1, 2, 3, 4], k: 5, expected: 2 },
    { nums: [3, 1, 3, 4, 3], k: 6, expected: 1 },
].forEach((testCase) => {
    const name = testCase.nums.slice();
    const result = maxOperations(testCase.nums, testCase.k);
    const isRight = result === testCase.expected;

    console.log(result);

    console.log(name,
        `${isRight ? "✅" : "❌"}`);
});    