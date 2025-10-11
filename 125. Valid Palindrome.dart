import 'testable.dart';

class Solution {
  bool isPalindrome(String s) {
    var left = 0;
    var right = s.length - 1;

    while (left < right) {
      var leftCode = s.codeUnitAt(left);
      var rightCode = s.codeUnitAt(right);

      if (!isAlphaNum(leftCode)) {
        left++;
        continue;
      }

      if (!isAlphaNum(rightCode)) {
        right--;
        continue;
      }

      if (leftCode >= 65 && leftCode <= 90) leftCode += 32;
      if (rightCode >= 65 && rightCode <= 90) rightCode += 32;

      if (leftCode != rightCode) return false;

      left++;
      right--;
    }

    return true;
  }

  bool isAlphaNum(int code) =>
      (code >= 48 && code <= 57) ||
      (code >= 65 && code <= 90) ||
      (code >= 97 && code <= 122);
}

class SolutionTest extends Testable<bool> with ConsoleTestOutput {
  final String s;

  SolutionTest({required this.s, required super.result});

  @override
  bool computeResult() => Solution().isPalindrome(s);
}

void main(List<String> args) {
  [
    SolutionTest(s: "A man, a plan, a canal: Panama", result: true),
    SolutionTest(s: "race a car", result: false)
  ].test();
}
