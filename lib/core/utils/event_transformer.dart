import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// Define transformer types
enum EventTransformerType { none, debounce, droppable }
EventTransformer<Event> debounceSequential<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}

EventTransformer<T> droppable<T>() {
  return (events, mapper) => events.switchMap(mapper);
}