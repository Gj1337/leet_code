// Every valid email consists of a local name and a domain name, separated by the '@' sign. Besides lowercase letters, the email may contain one or more '.' or '+'.
// For example, in "alice@leetcode.com", "alice" is the local name, and "leetcode.com" is the domain name.
// If you add periods '.' between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name. Note that this rule does not apply to domain names.
// For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.
// If you add a plus '+' in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered. Note that this rule does not apply to domain names.
// For example, "m.y+name@email.com" will be forwarded to "my@email.com".
// It is possible to use both of these rules at the same time.
// Given an array of strings emails where we send one email to each emails[i], return the number of different addresses that actually receive mails.

// Example 1:
// Input: emails = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
// Output: 2
// Explanation: "testemail@leetcode.com" and "testemail@lee.tcode.com" actually receive mails.

// Example 2:
// Input: emails = ["a@leetcode.com","b@leetcode.com","c@leetcode.com"]
// Output: 3

// Constraints:
// 1 <= emails.length <= 100
// 1 <= emails[i].length <= 100
// emails[i] consist of lowercase English letters, '+', '.' and '@'.
// Each emails[i] contains exactly one '@' character.
// All local and domain names are non-empty.
// Local names do not start with a '+' character.
// Domain names end with the ".com" suffix.
// Domain names must contain at least one character before ".com" suffix.

import 'testable.dart';

class Solution {
  int numUniqueEmails(List<String> emails) {
    final uniqueEmails = <String>{};

    for (final email in emails) {
      final buffer = StringBuffer();

      for (int i = 0; i < email.length; i++) {
        final char = email[i];

        if (char == '.') {
          continue;
        }

        if (char == '+') {
          while (email[i] != '@') {
            i++;
          }
        }

        if (email[i] == '@') {
          buffer.write(email.substring(i));
          break;
        }
        buffer.write(email[i]);
      }

      uniqueEmails.add(buffer.toString());
    }

    return uniqueEmails.length;
  }
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  final List<String> emails;

  SolutionTest({required this.emails, required super.result});

  @override
  int computeResult() => Solution().numUniqueEmails(emails);
}

void main(List<String> args) {
  [
    // Example 1: Standard case with dots and plus signs
    SolutionTest(
      emails: [
        "test.email+alex@leetcode.com",
        "test.e.mail+bob.cathy@leetcode.com",
        "testemail+david@lee.tcode.com",
      ],
      result: 2,
    ),

    // Example 2: Simple unique addresses
    SolutionTest(
      emails: ["a@leetcode.com", "b@leetcode.com", "c@leetcode.com"],
      result: 3,
    ),

    // Case 3: Multiple plus signs (only the first one matters)
    SolutionTest(
      emails: [
        "test.email+alex+foo@leetcode.com",
        "testemail+bar@leetcode.com",
      ],
      result: 1,
    ),

    // Case 4: Dots in domain names (should NOT be removed)
    SolutionTest(
      emails: ["testemail@lee.tcode.com", "testemail@leet.code.com"],
      result: 2,
    ),

    // Case 5: Plus sign immediately after local name characters
    SolutionTest(
      emails: ["test+@leetcode.com", "test@leetcode.com"],
      result: 1,
    ),

    // Case 6: Local name with only one character (Minimum length)
    SolutionTest(
      emails: ["a+b@leetcode.com", "a.b@leetcode.com", "ab@leetcode.com"],
      result: 2, // "a@leetcode.com" and "ab@leetcode.com"
    ),

    // Case 7: Same local name, different domains
    SolutionTest(
      emails: [
        "test@leetcode.com",
        "test@leetcode.org.com",
        "test@leetc.ode.com",
      ],
      result: 3,
    ),

    // Case 8: Maximum dot density
    SolutionTest(
      emails: ["t.e.s.t.e.m.a.i.l@leetcode.com", "testemail@leetcode.com"],
      result: 1,
    ),

    // Case 9: Ignore dots/plus logic in domain
    // (Though constraints say domain only has letters and dots,
    // it's good to ensure logic doesn't leak)
    SolutionTest(
      emails: ["test@leetcode+withplus.com", "test@leetcode.com"],
      result: 2,
    ),
  ].test();
}
