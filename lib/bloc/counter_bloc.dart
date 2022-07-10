import 'dart:async';

enum CounterEvent { increment, decrement }

class CounterBloc {
  int counter = 0;

  final StreamController<CounterEvent> _eventController = StreamController();

  StreamSink<CounterEvent> get eventSink => _eventController.sink;

  final StreamController<int> _counterController = StreamController();

  StreamSink<int> get _counterSink => _counterController.sink;

  Stream<int> get counterStream => _counterController.stream;

  CounterBloc() {
    _eventController.stream.listen(_mapEventToState);
    _counterSink.add(counter);
  }

  void _mapEventToState(CounterEvent event) {
    if (event == CounterEvent.increment) {
      counter++;
    } else {
      counter--;
    }

    _counterSink.add(counter);
  }

  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}
