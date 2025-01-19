// The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such
// that each number is the sum of the two preceding ones, starting from 0 and 1. That is,

// F(0) = 0, F(1) = 1
// F(n) = F(n - 1) + F(n - 2), for n > 1.

// Given n, calculate F(n).

// Example 1:

// Input: n = 2
// Output: 1
// Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.

// Example 2:

// Input: n = 3
// Output: 2
// Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.

// Example 3:

// Input: n = 4
// Output: 3
// Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.

// Constraints:

//     0 <= n <= 30

class Solution {
    fun fib(n: Int): Int {
        if (n == 0) return 0

        var a = 0
        var b = 1

        for (i in 2..n) {
            val tmp = a + b
            a = b
            b = tmp
        }

        return b
    }
}

val expectedResults =
    mapOf(
        0 to 0,
        1 to 1,
        2 to 1,
        3 to 2,
        4 to 3,
        5 to 5,
        6 to 8,
        7 to 13,
        8 to 21,
        9 to 34,
        10 to 55,
        11 to 89,
        12 to 144,
        13 to 233,
        14 to 377,
        15 to 610,
        16 to 987,
        17 to 1597,
        18 to 2584,
        19 to 4181,
        20 to 6765,
        21 to 10946,
        22 to 17711,
        23 to 28657,
        24 to 46368,
        25 to 75025,
        26 to 121393,
        27 to 196418,
        28 to 317811,
        29 to 514229,
        30 to 832040
    )

val solution = Solution()

for (key in expectedResults.keys) {
    val result = solution.fib(key)

    val matchResult = result == expectedResults[key]

    println("n=$key result=$result${if (matchResult) "✅" else "!=${expectedResults[key]}❌"}")
}


