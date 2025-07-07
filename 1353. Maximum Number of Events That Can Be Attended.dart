// You are given an array of events where events[i] = [startDayi, endDayi].
// Every event i starts at startDayi and ends at endDayi.
// You can attend an event i at any day d where startTimei <= d <= endTimei.
// You can only attend one event at any time d.
// Return the maximum number of events you can attend.

// Example 1:
// Input: events = [[1,2],[2,3],[3,4]]
// Output: 3
// Explanation: You can attend all the three events.
// One way to attend them all is as shown.
// Attend the first event on day 1.
// Attend the second event on day 2.
// Attend the third event on day 3.

// Example 2:
// Input: events= [[1,2],[2,3],[3,4],[1,2]]
// Output: 4

// Constraints:
//     1 <= events.length <= 105
//     events[i].length == 2
//     1 <= startDayi <= endDayi <= 105

import 'testable.dart';

class Solution {
  int maxEvents(List<List<int>> events) {
    final daysCount = events.fold(
      [0, 0],
      (previous, current) => previous.last > current.last ? previous : current,
    ).last;

    events.sort((first, second) => first.first - second.first);

    final priorityQueue = PriorityQueue<int>();
    var result = 0;

    var lastEventIndex = 0;
    for (var i = 1; i <= daysCount; i++) {
      if (result == events.length) break;

      while (lastEventIndex < events.length &&
          events[lastEventIndex].first <= i) {
        priorityQueue.add(events[lastEventIndex].last);

        lastEventIndex++;
      }

      while (priorityQueue.isNotEmpty && priorityQueue.peek < i) {
        priorityQueue.remove();
      }

      if (priorityQueue.isNotEmpty) {
        priorityQueue.remove();
        result++;
      }
    }

    return result;
  }
}

class PriorityQueue<T> {
  final List<T> _heap = [];
  final Comparator<T> _comparator;

  PriorityQueue([Comparator<T>? comparator])
    : _comparator = comparator ?? ((a, b) => (a as Comparable).compareTo(b));

  bool get isEmpty => _heap.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get length => _heap.length;
  T get peek => _heap.first;

  void add(T value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  void addAll(Iterable<T> values) {
    for (final value in values) {
      add(value);
    }
  }

  T remove() {
    if (_heap.isEmpty) throw StateError('PriorityQueue is empty');

    final T result = _heap.first;
    final T last = _heap.removeLast();

    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _bubbleDown(0);
    }

    return result;
  }

  void _bubbleUp(int index) {
    while (index > 0) {
      final parent = (index - 1) >> 1;
      if (_comparator(_heap[index], _heap[parent]) >= 0) break;
      _swap(index, parent);
      index = parent;
    }
  }

  void _bubbleDown(int index) {
    final length = _heap.length;
    while (true) {
      final left = (index << 1) + 1;
      final right = left + 1;
      int smallest = index;

      if (left < length && _comparator(_heap[left], _heap[smallest]) < 0) {
        smallest = left;
      }
      if (right < length && _comparator(_heap[right], _heap[smallest]) < 0) {
        smallest = right;
      }

      if (smallest == index) break;
      _swap(index, smallest);
      index = smallest;
    }
  }

  void _swap(int i, int j) {
    final temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  @override
  String toString() => 'PriorityQueue(${_heap.toString()})';
}

class SolutionTest extends Testable<int> with ConsoleTestOutput {
  SolutionTest({required this.events, required super.result});

  final List<List<int>> events;

  @override
  int computeResult() => Solution().maxEvents(events);
}

void main(List<String> args) {
  [
    SolutionTest(
      events: [
        [2, 5],
        [2, 4],
        [1, 8],
        [1, 7],
      ],
      result: 4,
    ),
    SolutionTest(
      events: [
        [1, 2],
        [2, 3],
        [3, 4],
      ],
      result: 3,
    ),
    SolutionTest(
      events: [
        [1, 2],
        [2, 3],
        [3, 4],
        [1, 2],
      ],
      result: 4,
    ),
    SolutionTest(
      events: [
        [1, 4],
        [4, 4],
        [2, 2],
        [3, 4],
        [1, 1],
      ],
      result: 4,
    ),
    SolutionTest(
      events: [
        [1, 100000],
      ],
      result: 1,
    ),
    SolutionTest(
      events: [
        [1, 1],
        [1, 2],
        [1, 3],
        [1, 4],
        [1, 5],
        [1, 6],
        [1, 7],
      ],
      result: 7,
    ),
    SolutionTest(
      events: [
        [1, 1],
        [2, 2],
        [3, 3],
        [4, 4],
        [5, 5],
      ],
      result: 5,
    ),
    SolutionTest(
      events: [
        [1, 2],
        [1, 2],
        [3, 3],
        [1, 5],
        [1, 5],
      ],
      result: 5,
    ),
    SolutionTest(
      events: [
        [1, 5],
        [1, 5],
        [1, 5],
        [2, 3],
        [2, 3],
      ],
      result: 5,
    ),
    SolutionTest(events: [], result: 0),
    SolutionTest(
      events: [
        [1, 1],
        [1, 1],
        [1, 1],
        [1, 1],
      ],
      result: 1,
    ),
    SolutionTest(
      events: [
        [1, 10],
        [2, 10],
        [3, 10],
        [4, 10],
      ],
      result: 4,
    ),
  ].test();
}
