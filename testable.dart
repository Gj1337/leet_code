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

      final isCorrect = _areEqual(result, testCase.result);

      print(
        'Test case $i '
        '${isCorrect ? '✅' : '❌\r\nYour result $result != ${testCase.result}\r\n'}',
      );
    }
  }

  bool _areEqual(dynamic a, dynamic b) => switch ((a, b)) {
        (List a, List b) => _areListEqual(a, b),
        (Set a, Set b) => _areSetsEqual(a, b),
        (Map a, Map b) => _areMapsEqual(a, b),
        _ => a == b
      };

  bool _areListEqual(List a, List b) {
    if (a.length != b.length) return false;

    for (var i = 0; i < a.length; i++) {
      if (!_areEqual(a[i], b[i])) {
        return false;
      }
    }

    return true;
  }

  bool _areSetsEqual(Set a, Set b) {
    return a.length == b.length && a.containsAll(b) && b.containsAll(a);
  }

  bool _areMapsEqual(Map a, Map b) {
    if (a.length != b.length) return false;

    for (final key in a.keys) {
      if (!b.containsKey(key) || !_areEqual(a[key], b[key])) {
        return false;
      }
    }
    return true;
  }
}
