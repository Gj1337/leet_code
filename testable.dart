final class TestResult<T> {
  final bool passed;
  final T computedResult;
  final T expectedResult;
  final Duration timeTaken;

  TestResult({
    required this.passed,
    required this.computedResult,
    required this.expectedResult,
    required this.timeTaken,
  });
}

abstract class Testable<T> {
  Testable({
    this.name,
    required this.result,
  });

  final T result;
  String? name;

  T computeResult();

  bool validateResult(T computedResult, T expectedResult) =>
      _areEqual(computedResult, expectedResult);

  TestResult<T> test() {
    final stopwatch = Stopwatch()..start();
    final computedResult = computeResult();
    stopwatch.stop();

    final passed = validateResult(computedResult, result);

    return TestResult<T>(
        passed: passed,
        computedResult: computedResult,
        expectedResult: result,
        timeTaken: stopwatch.elapsed);
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
      if (!_areEqual(a[i], b[i])) return false;
    }
    return true;
  }

  bool _areSetsEqual(Set a, Set b) =>
      a.length == b.length && a.containsAll(b) && b.containsAll(a);

  bool _areMapsEqual(Map a, Map b) {
    if (a.length != b.length) return false;

    for (final key in a.keys) {
      if (!b.containsKey(key) || !_areEqual(a[key], b[key])) return false;
    }

    return true;
  }
}

mixin ConsoleTestOutput<T> on Testable<T> {
  @override
  TestResult<T> test() {
    final result = super.test();

    final TestResult(:passed, :computedResult, :expectedResult, :timeTaken) =
        result;

    print(' ${name ?? "Test"} \r\n'
        'Result: ${passed ? "PASSED ✅" : "FAILED ❌"}\r\n'
        '${!passed ? 'Expected: $expectedResult \r\n' : ''}'
        'Computed: $computedResult\r\n'
        'Time taken: ${timeTaken.inMicroseconds} μs \r\n');

    return result;
  }
}

extension TestingListExtention<T> on List<Testable<T>> {
  List<TestResult<T>> test() => List.generate(
        length,
        (index) {
          this[index].name = this[index].name ?? 'Test case $index';

          return this[index].test();
        },
      );
}
