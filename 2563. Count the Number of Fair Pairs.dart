// Given a 0-indexed integer array nums of size n and two integers lower and upper, return the number of fair pairs.

// A pair (i, j) is fair if:

// 0 <= i < j < n, and
// lower <= nums[i] + nums[j] <= upper

// Example 1:

// Input: nums = [0,1,7,4,4,5], lower = 3, upper = 6
// Output: 6
// Explanation: There are 6 fair pairs: (0,3), (0,4), (0,5), (1,3), (1,4), and (1,5).
// Example 2:

// Input: nums = [1,7,9,2,5], lower = 11, upper = 11
// Output: 1
// Explanation: There is a single fair pair: (2,3).

// Constraints:

// 1 <= nums.length <= 105
// nums.length == n
// -109 <= nums[i] <= 109
// -109 <= lower <= upper <= 109

class Solution {
  int _countPairs(List<int> nums, int target) {
    nums.sort();

    var result = 0;

    var left = 0;
    var right = nums.length - 1;

    while (left <= right) {
      final sum = nums[left] + nums[right];

      if (sum > target) {
        right--;
      } else {
        result += right - left;
        left++;
      }
    }

    return result;
  }

  int countFairPairs(List<int> nums, int lower, int upper) {
    nums.sort();

    final result = _countPairs(nums, upper ) - _countPairs(nums, lower-1);

    return result;
  }
}

typedef TestCase = ({
  List<int> nums,
  int upper,
  int lower,
  int result,
});

main() {
  final solution = Solution();

  final List<TestCase> testCases = [
    (nums: [0, 1, 7, 4, 4, 5], lower: 3, upper: 6, result: 6),
    (nums: [1, 7, 9, 2, 5], lower: 11, upper: 11, result: 1),
  ];

  for (var i = 0; i < testCases.length; i++) {
    final testCase = testCases[i];

    final result =
        solution.countFairPairs(testCase.nums, testCase.lower, testCase.upper);
    final isCorrect = result == testCase.result;

    print('Test case $i ${isCorrect ? '✅' : '❌'}');
  }
}
