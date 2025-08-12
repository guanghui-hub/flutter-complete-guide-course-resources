import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Models
class Todo extends Equatable {
  final String id;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object> get props => [id, title, completed];
}

// Events
abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoAdded extends TodoEvent {
  final String title;

  TodoAdded(this.title);

  @override
  List<Object> get props => [title];
}

class TodoToggled extends TodoEvent {
  final String id;

  TodoToggled(this.id);

  @override
  List<Object> get props => [id];
}

class TodoDeleted extends TodoEvent {
  final String id;

  TodoDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class TodosCleared extends TodoEvent {}

// States
class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({required this.todos});

  TodoState copyWith({List<Todo>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }

  @override
  List<Object> get props => [todos];
}

// Bloc
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState(todos: [])) {
    on<TodoAdded>(_onTodoAdded);
    on<TodoToggled>(_onTodoToggled);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodosCleared>(_onTodosCleared);
  }

  void _onTodoAdded(TodoAdded event, Emitter<TodoState> emit) {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title,
      completed: false,
    );
    emit(state.copyWith(todos: [...state.todos, newTodo]));
  }

  void _onTodoToggled(TodoToggled event, Emitter<TodoState> emit) {
    final updatedTodos = state.todos.map((todo) {
      return todo.id == event.id
          ? todo.copyWith(completed: !todo.completed)
          : todo;
    }).toList();
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) {
    final updatedTodos = state.todos.where((todo) => todo.id != event.id).toList();
    emit(state.copyWith(todos: updatedTodos));
  }

  void _onTodosCleared(TodosCleared event, Emitter<TodoState> emit) {
    final activeTodos = state.todos.where((todo) => !todo.completed).toList();
    emit(state.copyWith(todos: activeTodos));
  }
}