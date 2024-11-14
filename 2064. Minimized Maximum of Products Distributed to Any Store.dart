// You are given an integer n indicating there are n specialty retail stores. There are m product types of varying amounts, which are given as a 0-indexed integer array quantities, where quantities[i] represents the number of products of the ith product type.

// You need to distribute all products to the retail stores following these rules:

// A store can only be given at most one product type but can be given any amount of it.
// After distribution, each store will have been given some number of products (possibly 0). Let x represent the maximum number of products given to any store. You want x to be as small as possible, i.e., you want to minimize the maximum number of products that are given to any store.
// Return the minimum possible x.

// Example 1:

// Input: n = 6, quantities = [11,6]
// Output: 3
// Explanation: One optimal way is:
// - The 11 products of type 0 are distributed to the first four stores in these amounts: 2, 3, 3, 3
// - The 6 products of type 1 are distributed to the other two stores in these amounts: 3, 3
// The maximum number of products given to any store is max(2, 3, 3, 3, 3, 3) = 3.
// Example 2:

// Input: n = 7, quantities = [15,10,10]
// Output: 5
// Explanation: One optimal way is:
// - The 15 products of type 0 are distributed to the first three stores in these amounts: 5, 5, 5
// - The 10 products of type 1 are distributed to the next two stores in these amounts: 5, 5
// - The 10 products of type 2 are distributed to the last two stores in these amounts: 5, 5
// The maximum number of products given to any store is max(5, 5, 5, 5, 5, 5, 5) = 5.
// Example 3:

// Input: n = 1, quantities = [100000]
// Output: 100000
// Explanation: The only optimal way is:
// - The 100000 products of type 0 are distributed to the only store.
// The maximum number of products given to any store is max(100000) = 100000.

// Constraints:

// m == quantities.length
// 1 <= m <= n <= 105
// 1 <= quantities[i] <= 105

class Solution {
  bool _canBeDestirbuted(int amountOfPoducts, List<int> quantities, int n) {
    var shopNumber = 0;

    for (var productIndex = 0;
        productIndex < quantities.length;
        productIndex++) {
      if (shopNumber > n) return false;

      final productCount = quantities[productIndex];

      final demandingShopsForProduct = (productCount / amountOfPoducts).ceil();

      shopNumber += demandingShopsForProduct;
    }

    return !(shopNumber > n);
  }

  int minimizedMaximum(int n, List<int> quantities) {
    int left = 1;
    int right = quantities.max;

    while (left < right) {
      final middle = (left + right) ~/ 2;

      if (_canBeDestirbuted(middle, quantities, n)) {
        right = middle;
      } else {
        left = middle + 1;
      }
    }

    return left;
  }
}

extension _<T extends num> on List<T> {
  T get max => this.isNotEmpty
      ? this.fold(this.first,
          (max, currentNumber) => currentNumber > max ? currentNumber : max)
      : throw ('Empty list');
}

typedef TestCase = ({
  int n,
  List<int> quantities,
  int result,
});

main() {
  final solution = Solution();

  final List<TestCase> testCases = [
    (n: 6, quantities: [11, 6], result: 3),
    (n: 7, quantities: [15, 10, 10], result: 5),
    (n: 1, quantities: [1], result: 1),
    (
      n: 100000,
      quantities: [
        4,
        4,
        4,
        2,
        4,
        2,
        4,
        1,
        5,
        4,
        5,
        4,
        1,
        1,
        2,
        2,
        4,
        1,
        1,
        4,
        5,
        3,
        3,
        4,
        1,
        2
      ],
      result: 1,
    ),
  ];

  for (var i = 0; i < testCases.length; i++) {
    final testCase = testCases[i];

    final result = solution.minimizedMaximum(testCase.n, testCase.quantities);
    final isCorrect = result == testCase.result;

    print('Test case $i ${isCorrect ? '✅' : '❌'}');
  }
}
