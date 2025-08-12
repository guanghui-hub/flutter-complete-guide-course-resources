import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// 计数器状态Provider
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// 消息Provider - 依赖于计数器
final messageProvider = Provider<String>((ref) {
  final count = ref.watch(counterProvider);
  if (count == 0) {
    return '计数器已重置';
  } else if (count > 0) {
    return '正数: $count';
  } else {
    return '负数: $count';
  }
});

// 用户状态Provider
class User {
  final String name;
  final String email;
  final bool isLoggedIn;

  User({
    required this.name,
    required this.email,
    required this.isLoggedIn,
  });

  User copyWith({
    String? name,
    String? email,
    bool? isLoggedIn,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(name: '未登录用户', email: '', isLoggedIn: false));

  void login(String name, String email) {
    state = User(name: name, email: email, isLoggedIn: true);
  }

  void logout() {
    state = User(name: '未登录用户', email: '', isLoggedIn: false);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

// 待办事项Provider
class Todo {
  final String id;
  final String title;
  final bool completed;

  Todo({
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
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      completed: false,
    );
    state = [...state, todo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void clearCompleted() {
    state = state.where((todo) => !todo.completed).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

// 过滤器Provider
enum TodoFilter { all, active, completed }

final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

// 过滤后的待办事项Provider
final filteredTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoFilter.all:
      return todos;
    case TodoFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoFilter.completed:
      return todos.where((todo) => todo.completed).toList();
  }
});

// 统计Provider
final todoStatsProvider = Provider<Map<String, int>>((ref) {
  final todos = ref.watch(todoListProvider);
  final total = todos.length;
  final completed = todos.where((todo) => todo.completed).length;
  final active = total - completed;

  return {
    'total': total,
    'completed': completed,
    'active': active,
  };
});

// 异步数据Provider示例
final weatherProvider = FutureProvider<String>((ref) async {
  // 模拟API调用
  await Future.delayed(Duration(seconds: 2));
  final random = DateTime.now().millisecond % 4;
  final weathers = ['晴天', '多云', '雨天', '雪天'];
  return weathers[random];
});

// 主题Provider
class AppTheme {
  final bool isDarkMode;
  final Color primaryColor;

  AppTheme({
    required this.isDarkMode,
    required this.primaryColor,
  });

  AppTheme copyWith({
    bool? isDarkMode,
    Color? primaryColor,
  }) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }

  ThemeData get themeData {
    return ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primarySwatch: MaterialColor(
        primaryColor.value,
        <int, Color>{
          50: primaryColor.withOpacity(0.1),
          100: primaryColor.withOpacity(0.2),
          200: primaryColor.withOpacity(0.3),
          300: primaryColor.withOpacity(0.4),
          400: primaryColor.withOpacity(0.5),
          500: primaryColor.withOpacity(0.6),
          600: primaryColor.withOpacity(0.7),
          700: primaryColor.withOpacity(0.8),
          800: primaryColor.withOpacity(0.9),
          900: primaryColor.withOpacity(1.0),
        },
      ),
    );
  }
}

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme(isDarkMode: false, primaryColor: Colors.purple));

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changePrimaryColor(Color color) {
    state = state.copyWith(primaryColor: color);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});