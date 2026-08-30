// There is an element in nums that has the lowest value and an element that has the highest value. We call them the minimum and maximum respectively. Your goal is to remove both these elements from the array.
//
// A deletion is defined as either removing an element from the front of the array or removing an element from the back of the array.
//
// Return the minimum number of deletions it would take to remove both the minimum and maximum element from the array.
//
// Example 1:
// Input: nums = [2,10,7,5,4,1,8,6]
// Output: 5
// Explanation:
// The minimum element in the array is nums[5], which is 1.
// The maximum element in the array is nums[1], which is 10.
// We can remove both the minimum and maximum by removing 2 elements from the front and 3 elements from the back.
// This results in 2 + 3 = 5 deletions, which is the minimum number possible.
//
// Example 2:
// Input: nums = [0,-4,19,1,8,-2,-3,5]
// Output: 3
// Explanation:
// The minimum element in the array is nums[1], which is -4.
// The maximum element in the array is nums[2], which is 19.
// We can remove both the minimum and maximum by removing 3 elements from the front.
// This results in only 3 deletions, which is the minimum number possible.
//
// Example 3:
// Input: nums = [101]
// Output: 1
// Explanation:
// There is only one element in the array, which makes it both the minimum and maximum element.
// We can remove it with 1 deletion.
//
// Constraints:
// 1 <= nums.length <= 105
// -105 <= nums[i] <= 105
// The integers in nums are distinct.

import 'testable.dart';

class Solution {
  int minimumDeletions(List<int> nums) {
    var minIndex = 0, maxIndex = 0;

    for (var i = 1; i < nums.length; i++) {
      if (nums[i] < nums[minIndex]) minIndex = i;
      if (nums[i] > nums[maxIndex]) maxIndex = i;
    }

    final startIndex = minIndex < maxIndex ? minIndex : maxIndex;
    final EndIndex = minIndex < maxIndex ? maxIndex : minIndex;

    final cutFromLeftCost = EndIndex + 1;
    final cutFromRightCost = nums.length - startIndex;
    final cutBothSidesCost = (startIndex + 1) + (nums.length - EndIndex);

    return [
      cutFromLeftCost,
      cutFromRightCost,
      cutBothSidesCost,
    ].reduce((a, b) => a < b ? a : b);
  }
}

// Solution for list without distinct numbers (with repeated numbers)
//
// class Solution {
//   int minimumDeletions(List<int> nums) {
//     var max = nums.first;
//     var maxIndexes = [0];
//     var min = nums.first;
//     var minIndexes = [0];
//
//     for (var i = 1; i < nums.length; i++) {
//       final number = nums[i];
//
//       if (max == number || min == number) {
//         maxIndexes.add(i);
//       } else if (max < number) {
//         max = number;
//         maxIndexes = [i];
//       } else if (min > number) {
//         min = number;
//         minIndexes = [i];
//       }
//     }
//
//     var startIndexMax = nums.length - 1;
//     var endIndexMax = 0;
//
//     for (final index in maxIndexes) {
//       if (index < startIndexMax) startIndexMax = index;
//       if (index > endIndexMax) endIndexMax = index;
//     }
//
//     var startIndexMin = nums.length - 1;
//     var endIndexMin = 0;
//
//     for (final index in minIndexes) {
//       if (index < startIndexMin) startIndexMin = index;
//       if (index > endIndexMin) endIndexMin = index;
//     }
//
//     final biggestIndexForLeftCut = startIndexMax > startIndexMin
//         ? startIndexMax
//         : startIndexMin;
//
//     final leftCutCost = biggestIndexForLeftCut + 1;
//
//     final smallerIndexForRightCut = endIndexMax > endIndexMin
//         ? endIndexMin
//         : endIndexMax;
//
//     final rightCutCost = nums.length - smallerIndexForRightCut;
//
//     final bothCutOneCost = startIndexMin + 1 + (nums.length - endIndexMax);
//     final bothCutTwoCost = startIndexMax + 1 + (nums.length - endIndexMin);
//
//     return [
//       leftCutCost,
//       rightCutCost,
//       bothCutTwoCost,
//       bothCutOneCost,
//     ].reduce((a, b) => a > b ? b : a);
//   }
// }

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<int> nums;

  SolutionTest({required this.nums, required super.result});

  @override
  int computeResult() => Solution().minimumDeletions(nums);
}

void main(List<String> args) {
  [
    SolutionTest(nums: [2, 10, 7, 5, 4, 1, 8, 6], result: 5),
    SolutionTest(nums: [0, -4, 19, 1, 8, -2, -3, 5], result: 3),
    SolutionTest(nums: [101], result: 1),
  ].test();
}
