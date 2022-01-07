import 'dart:async';
import 'counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _inCounter => _counterStateController.sink;

  //For state, exposing only a stream which ouputs data
  //Stream responsible for exposing the output
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();

  //For events, exposing only a sink which is an input
  //Sink forms the input
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    //Whenever there is a new event , we want to mao it to new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
