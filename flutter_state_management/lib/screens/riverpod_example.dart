import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/riverpod_providers.dart';

class RiverpodExample extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: theme.themeData,
      home: RiverpodExampleScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RiverpodExampleScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod 示例'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(),
            SizedBox(height: 20),
            _buildCounterSection(ref),
            SizedBox(height: 20),
            _buildUserSection(ref),
            SizedBox(height: 20),
            _buildWeatherSection(ref),
            SizedBox(height: 20),
            _buildTodoSection(ref),
            SizedBox(height: 20),
            _buildThemeSection(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Riverpod 特点',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              '• Provider的现代化替代方案\n'
              '• 编译时安全，避免运行时错误\n'
              '• 更好的测试支持\n'
              '• 支持异步状态管理\n'
              '• Provider依赖关系管理\n'
              '• 自动资源清理',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterSection(WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final message = ref.watch(messageProvider);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '计数器示例 (Riverpod)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => ref.read(counterProvider.notifier).decrement(),
                  icon: Icon(Icons.remove),
                  label: Text('减少'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => ref.read(counterProvider.notifier).reset(),
                  icon: Icon(Icons.refresh),
                  label: Text('重置'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => ref.read(counterProvider.notifier).increment(),
                  icon: Icon(Icons.add),
                  label: Text('增加'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSection(WidgetRef ref) {
    final user = ref.watch(userProvider);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '用户信息管理',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: user.isLoggedIn 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        user.isLoggedIn ? Icons.person : Icons.person_outline,
                        color: user.isLoggedIn ? Colors.green : Colors.grey,
                      ),
                      SizedBox(width: 8),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (user.isLoggedIn) ...[
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.green),
                        SizedBox(width: 8),
                        Text(user.email),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 16),
            if (!user.isLoggedIn)
              ElevatedButton.icon(
                onPressed: () => ref.read(userProvider.notifier).login('李四', 'lisi@example.com'),
                icon: Icon(Icons.login),
                label: Text('登录'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () => ref.read(userProvider.notifier).logout(),
                icon: Icon(Icons.logout),
                label: Text('登出'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherSection(WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '异步数据示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            weatherAsync.when(
              data: (weather) => Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      '今天天气: $weather',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              loading: () => Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('正在获取天气信息...'),
                  ],
                ),
              ),
              error: (error, stack) => Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Text('获取天气信息失败'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => ref.refresh(weatherProvider),
              icon: Icon(Icons.refresh),
              label: Text('刷新天气'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodoSection(WidgetRef ref) {
    final todos = ref.watch(filteredTodosProvider);
    final filter = ref.watch(todoFilterProvider);
    final stats = ref.watch(todoStatsProvider);
    final textController = TextEditingController();
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '待办事项',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '总计: ${stats['total']}, 完成: ${stats['completed']}, 待办: ${stats['active']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: '输入待办事项...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      ref.read(todoListProvider.notifier).addTodo(textController.text);
                      textController.clear();
                    }
                  },
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip(ref, TodoFilter.all, '全部', filter),
                _buildFilterChip(ref, TodoFilter.active, '待办', filter),
                _buildFilterChip(ref, TodoFilter.completed, '完成', filter),
              ],
            ),
            SizedBox(height: 16),
            if (todos.isEmpty)
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  '暂无待办事项',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => ref.read(todoListProvider.notifier).toggleTodo(todo.id),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.completed ? TextDecoration.lineThrough : null,
                          color: todo.completed ? Colors.grey : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => ref.read(todoListProvider.notifier).removeTodo(todo.id),
                      ),
                    ),
                  );
                },
              ),
            if (stats['completed']! > 0) ...[
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => ref.read(todoListProvider.notifier).clearCompleted(),
                icon: Icon(Icons.clear_all),
                label: Text('清除已完成'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(WidgetRef ref, TodoFilter filterValue, String label, TodoFilter currentFilter) {
    return FilterChip(
      label: Text(label),
      selected: currentFilter == filterValue,
      onSelected: (_) => ref.read(todoFilterProvider.notifier).state = filterValue,
      selectedColor: Colors.purple.withOpacity(0.3),
    );
  }

  Widget _buildThemeSection(WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '主题控制',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('深色模式'),
                Switch(
                  value: theme.isDarkMode,
                  onChanged: (_) => ref.read(themeProvider.notifier).toggleDarkMode(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('主题颜色'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorButton(ref, Colors.blue, theme),
                _buildColorButton(ref, Colors.red, theme),
                _buildColorButton(ref, Colors.green, theme),
                _buildColorButton(ref, Colors.purple, theme),
                _buildColorButton(ref, Colors.orange, theme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(WidgetRef ref, Color color, AppTheme theme) {
    return GestureDetector(
      onTap: () => ref.read(themeProvider.notifier).changePrimaryColor(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: theme.primaryColor == color
              ? Border.all(color: Colors.white, width: 3)
              : null,
        ),
        child: theme.primaryColor == color
            ? Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }
}