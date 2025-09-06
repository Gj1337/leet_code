// We are playing the Guess Game. The game is as follows:
// I pick a number from 1 to n.
// You have to guess which number I picked 
//(the number I picked stays the same throughout the game).
// Every time you guess wrong, I will tell you whether
// the number I picked is higher or lower than your guess.
// You call a pre-defined API int guess(int num),
// which returns three possible results:
//     -1: Your guess is higher than the number I picked (i.e. num > pick).
//     1: Your guess is lower than the number I picked (i.e. num < pick).
//     0: your guess is equal to the number I picked (i.e. num == pick).
// Return the number that I picked.

// Example 1:
// Input: n = 10, pick = 6
// Output: 6

// Example 2:
// Input: n = 1, pick = 1
// Output: 1

// Example 3:
// Input: n = 2, pick = 1
// Output: 1

// Constraints:
//     1 <= n <= 231 - 1
//     1 <= pick <= n

/** 
 * Forward declaration of guess API.
 * @param {number} num   your guess
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0
 * var guess = function(num) {}
 */

// 1 2 3 4 5 6 9

function guessNumber(n: number): number {
    let start = 1, end = n;
    let guessedNumber: number;

    while (true) {
        guessedNumber = Math.floor(start+(end - start) / 2);
        let result = guess(guessedNumber);
        switch (result) {
            case 1: start = guessedNumber + 1;
                break;
            case -1: end = guessedNumber - 1;
                break;
            default: return guessedNumber;
        }
    }
};
