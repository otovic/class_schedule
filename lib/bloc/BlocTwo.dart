import 'dart:async';

import './bloc.dart';

class BlocTwo extends BlocBase {
  int _counter = 1000;

  final _counterController = StreamController<int>.broadcast();
  StreamSink<int> get _counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  final _cmdController = StreamController<int>.broadcast();
  StreamSink<int> get _cmdSink => _cmdController.sink;

  CounterBloc() {
    _cmdController.stream.listen((event) {
      _counterSink.add(this._counter);
    });
  }

  int get count => _counter;

  @override
  void dispose() {
    _counterController.close();
  }

  void handleState() {
    this._counter += 10;
    _cmdSink.add(this._counter);
  }
}