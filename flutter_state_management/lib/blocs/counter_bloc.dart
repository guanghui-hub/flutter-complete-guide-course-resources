import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class CounterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CounterIncrement extends CounterEvent {}
class CounterDecrement extends CounterEvent {}
class CounterReset extends CounterEvent {}

// States
class CounterState extends Equatable {
  final int count;
  final String message;
  final List<String> history;

  const CounterState({
    required this.count,
    required this.message,
    required this.history,
  });

  CounterState copyWith({
    int? count,
    String? message,
    List<String>? history,
  }) {
    return CounterState(
      count: count ?? this.count,
      message: message ?? this.message,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [count, message, history];
}

// Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(
    count: 0,
    message: '欢迎使用Bloc!',
    history: [],
  )) {
    on<CounterIncrement>(_onIncrement);
    on<CounterDecrement>(_onDecrement);
    on<CounterReset>(_onReset);
  }

  void _onIncrement(CounterIncrement event, Emitter<CounterState> emit) {
    final newCount = state.count + 1;
    final newMessage = '计数增加到: $newCount';
    final newHistory = _addToHistory(state.history, '增加: $newCount');
    
    emit(state.copyWith(
      count: newCount,
      message: newMessage,
      history: newHistory,
    ));
  }

  void _onDecrement(CounterDecrement event, Emitter<CounterState> emit) {
    final newCount = state.count - 1;
    final newMessage = '计数减少到: $newCount';
    final newHistory = _addToHistory(state.history, '减少: $newCount');
    
    emit(state.copyWith(
      count: newCount,
      message: newMessage,
      history: newHistory,
    ));
  }

  void _onReset(CounterReset event, Emitter<CounterState> emit) {
    final newHistory = _addToHistory(state.history, '重置: 0');
    
    emit(state.copyWith(
      count: 0,
      message: '计数器已重置',
      history: newHistory,
    ));
  }

  List<String> _addToHistory(List<String> currentHistory, String action) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    final newHistory = List<String>.from(currentHistory);
    newHistory.insert(0, '$timestamp - $action');
    if (newHistory.length > 10) {
      newHistory.removeLast();
    }
    return newHistory;
  }
}