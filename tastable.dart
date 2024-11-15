abstract class Testable<T> {
  Testable({required this.result});

  final T result;

  T computeResult();
}

extension TestingListExtention<T extends Testable> on List<T> {
  void test() {
    for (var i = 0; i < this.length; i++) {
      final testCase = this[i];
      final result = testCase.computeResult();

      final isCorrect = result == testCase.result;

      print(
        'Test case $i '
        '${isCorrect ? '✅' : '❌\r\nCorrect result $result!=${testCase.result}\r\n'}',
      );
    }
  }
}
