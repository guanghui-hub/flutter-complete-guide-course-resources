import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;
  String _message = '欢迎使用Provider!';
  List<String> _history = [];

  int get count => _count;
  String get message => _message;
  List<String> get history => _history;

  void increment() {
    _count++;
    _message = '计数增加到: $_count';
    _addToHistory('增加: $_count');
    notifyListeners();
  }

  void decrement() {
    _count--;
    _message = '计数减少到: $_count';
    _addToHistory('减少: $_count');
    notifyListeners();
  }

  void reset() {
    _count = 0;
    _message = '计数器已重置';
    _addToHistory('重置: $_count');
    notifyListeners();
  }

  void _addToHistory(String action) {
    _history.insert(0, '${DateTime.now().toString().substring(11, 19)} - $action');
    if (_history.length > 10) {
      _history.removeLast();
    }
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}

// 用户信息Provider
class UserProvider with ChangeNotifier {
  String _name = '未登录用户';
  String _email = '';
  bool _isLoggedIn = false;

  String get name => _name;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  void login(String name, String email) {
    _name = name;
    _email = email;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _name = '未登录用户';
    _email = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}

// 主题Provider
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  Color _primaryColor = Colors.blue;

  bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryColor;

  ThemeData get themeData {
    return ThemeData(
      brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      primarySwatch: MaterialColor(
        _primaryColor.value,
        <int, Color>{
          50: _primaryColor.withOpacity(0.1),
          100: _primaryColor.withOpacity(0.2),
          200: _primaryColor.withOpacity(0.3),
          300: _primaryColor.withOpacity(0.4),
          400: _primaryColor.withOpacity(0.5),
          500: _primaryColor.withOpacity(0.6),
          600: _primaryColor.withOpacity(0.7),
          700: _primaryColor.withOpacity(0.8),
          800: _primaryColor.withOpacity(0.9),
          900: _primaryColor.withOpacity(1.0),
        },
      ),
    );
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}