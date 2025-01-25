abstract class Testable<T> {
  Testable({required this.result});

  final T result;

  T computeResult();

  /// If test is passed result is true otherwise false;
  bool test() => _areEqual(computeResult(), result);

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

  bool _areSetsEqual(Set a, Set b) =>
      a.length == b.length && a.containsAll(b) && b.containsAll(a);

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

mixin ConsoleTestOutput<T> on Testable<T> {
  @override
  bool test() {
    final computedResult = computeResult();
    final isPassed = _areEqual(computeResult(), result);

    print(
      isPassed
          ? 'Passed ✅\r\n'
          : '❌ Your result $computedResult != $result\r\n',
    );

    return isPassed;
  }
}

extension TestingListExtention<T extends Testable> on List<T> {
  List<bool> test() => List.generate(
        this.length,
        (i) {
          if (this[i] is ConsoleTestOutput) {
            print('Test case $i');
          }

          return this[i].test();
        },
      );
}
