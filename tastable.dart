// abstract class TestCase<T extends Object> {
//   TestCase(this.result);

//   final T result;
// }

// extension TestExstention<T extends TestCase> on List<T>{

//   void test(T Function() testFunction){
//       for (var i = 0; i < this.length; i++) {
//     final testCase = this[i];

//     final result = testFunction.call();
//     final isCorrect = result == testCase.result;

//     print('Test case $i ${isCorrect ? '✅' : '❌'}');
//   }
//   }

// }

abstract class Testable<T> {
  Testable(this.result);

  final T result;

  T computeResult();
}

extension TestingListExtention<T extends Testable> on List<T> {
  void test() {
    for (var i = 0; i < this.length; i++) {
      final testCase = this[i];
      final result = testCase.computeResult.call();

      final isCorrect = result == testCase.result;

      print('Test case $i ${isCorrect ? '✅' : '❌'}');
    }
  }
}
