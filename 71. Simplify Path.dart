//You are given an absolute path for a Unix-style file system, which always begins with a slash '/'. Your task is to transform this absolute path into its simplified canonical path.
//
// The rules of a Unix-style file system are as follows:
//
// A single period '.' represents the current directory.
// A double period '..' represents the previous/parent directory.
// Multiple consecutive slashes such as '//' and '///' are treated as a single slash '/'.
// Any sequence of periods that does not match the rules above should be treated as a valid directory or file name. For example, '...' and '....' are valid directory or file names.
// The simplified canonical path should follow these rules:
//
// The path must start with a single slash '/'.
// Directories within the path must be separated by exactly one slash '/'.
// The path must not end with a slash '/', unless it is the root directory.
// The path must not have any single or double periods ('.' and '..') used to denote current or parent directories.
// Return the simplified canonical path.
//
// Example 1:
// Input: path = "/home/"
// Output: "/home"
// Explanation:
// The trailing slash should be removed.
//
// Example 2:
// Input: path = "/home//foo/"
// Output: "/home/foo"
// Explanation:
// Multiple consecutive slashes are replaced by a single one.
//
// Example 3:
// Input: path = "/home/user/Documents/../Pictures"
// Output: "/home/user/Pictures"
// Explanation:
// A double period ".." refers to the directory up a level (the parent directory).
//
// Example 4:
// Input: path = "/../"
// Output: "/"
// Explanation:
// Going one level up from the root directory is not possible.
//
// Example 5:
// Input: path = "/.../a/../b/c/../d/./"
// Output: "/.../b/d"
// Explanation:
// "..." is a valid name for a directory in this problem.
//
//
// Constraints:
// 1 <= path.length <= 3000
// path consists of English letters, digits, period '.', slash '/' or '_'.
// path is a valid absolute Unix path.

import 'testable.dart';

class Solution {
  String simplifyPath(String path) {
    final stack = <String>[];
    final buffer = StringBuffer();

    void processPart() {
      final part = buffer.toString();

      if (part == '..') {
        if (stack.isNotEmpty) {
          stack.removeLast();
        }
      } else if (part.isNotEmpty && part != '.') {
        stack.add(part);
      }

      buffer.clear();
    }

    for (var i = 0; i < path.length; i++) {
      path[i] == '/' ? processPart() : buffer.write(path[i]);
    }

    processPart();

    return '/${stack.join('/')}';
  }
}

class SolutionTest extends Testable<String> with ConsoleTestOutput {
  final String path;

  SolutionTest({required this.path, required super.result});

  @override
  String computeResult() => Solution().simplifyPath(path);
}

void main(List<String> args) {
  [
    SolutionTest(path: "/a/../../b/../c//.//", result: '/c'),
    SolutionTest(path: '///', result: '/'),
    SolutionTest(path: '/', result: '/'),
    SolutionTest(path: '/..', result: '/'),
    SolutionTest(path: "/home/", result: "/home"),
    SolutionTest(path: "/home//foo/", result: "/home/foo"),
    SolutionTest(
      path: "/home/user/Documents/../Pictures",
      result: "/home/user/Pictures",
    ),
    SolutionTest(path: "/../", result: '/'),
    SolutionTest(path: "/.../a/../b/c/../d/./", result: "/.../b/d"),
  ].test();
}
