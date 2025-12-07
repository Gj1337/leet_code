// Given two non-negative integers low and high. Return the count of odd numbers between low and high (inclusive).
//
// Example 1:
// Input: low = 3, high = 7
// Output: 3
// Explanation: The odd numbers between 3 and 7 are [3,5,7].
//
// Example 2:
// Input: low = 8, high = 10
// Output: 1
// Explanation: The odd numbers between 8 and 10 are [9].
//
// Constraints:
//
//     0 <= low <= high <= 10^9

// 13 14 15 16 17 18 19 20
// 11 12 13

function countOdds(low: number, high: number): number {
	const firstNumberIsOdd = low % 2 != 0;
	const totalRange = high - low + 1;
	const result = firstNumberIsOdd ? Math.ceil(totalRange / 2) : Math.floor(totalRange / 2);

	return result;
};

type TestCase = {
	low: number;
	high: number;
	output: number;
};


const testCases: TestCase[] = [
	{ low: 3, high: 7, output: 3 },
	{ low: 8, high: 10, output: 1 },
	{ low: 21, high: 22, output: 1 },
	{ low: 14, high: 17, output: 2 },
	{ low: 13, high: 20, output: 4 },
	{ low: 11, high: 13, output: 2 },

];


for (let i = 0; i < testCases.length; i++) {
	const testCase = testCases[i];
	const result = countOdds(testCase.low, testCase.high);
	const valid = result === testCase.output;

	console.log(`Test case ${i} ${valid ? '✅' : '❌'}`);
	if (!valid) console.log(`Expected ${testCase.output} != ${result}`);
	console.log('');
}

