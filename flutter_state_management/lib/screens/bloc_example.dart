import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/counter_bloc.dart';
import '../blocs/todo_bloc.dart';

class BlocExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => TodoBloc()),
      ],
      child: BlocExampleScreen(),
    );
  }
}

class BlocExampleScreen extends StatelessWidget {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc 示例'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(),
            SizedBox(height: 20),
            _buildCounterSection(),
            SizedBox(height: 20),
            _buildTodoSection(),
            SizedBox(height: 20),
            _buildHistorySection(),
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
                Icon(Icons.info, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Bloc 特点',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              '• Business Logic Component\n'
              '• 事件驱动的状态管理\n'
              '• 清晰的业务逻辑分离\n'
              '• 易于测试和调试\n'
              '• 支持状态流和事件流\n'
              '• 可预测的状态变化',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterSection() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '计数器示例 (Bloc)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${state.count}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => context.read<CounterBloc>().add(CounterDecrement()),
                      icon: Icon(Icons.remove),
                      label: Text('减少'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => context.read<CounterBloc>().add(CounterReset()),
                      icon: Icon(Icons.refresh),
                      label: Text('重置'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => context.read<CounterBloc>().add(CounterIncrement()),
                      icon: Icon(Icons.add),
                      label: Text('增加'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTodoSection() {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final completedCount = state.todos.where((todo) => todo.completed).length;
        final activeCount = state.todos.length - completedCount;

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
                      '待办事项 (Bloc)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '总计: ${state.todos.length}, 完成: $completedCount, 待办: $activeCount',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: '输入待办事项...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onSubmitted: (value) => _addTodo(context, value),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _addTodo(context, _todoController.text),
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                if (state.todos.isEmpty)
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
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.completed,
                            onChanged: (_) => context.read<TodoBloc>().add(TodoToggled(todo.id)),
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
                            onPressed: () => context.read<TodoBloc>().add(TodoDeleted(todo.id)),
                          ),
                        ),
                      );
                    },
                  ),
                if (completedCount > 0) ...[
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<TodoBloc>().add(TodosCleared()),
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
      },
    );
  }

  Widget _buildHistorySection() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '操作历史',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                if (state.history.isEmpty)
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '暂无操作历史',
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
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.history, size: 20),
                        title: Text(
                          state.history[index],
                          style: TextStyle(fontSize: 14),
                        ),
                        dense: true,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTodo(BuildContext context, String title) {
    if (title.isNotEmpty) {
      context.read<TodoBloc>().add(TodoAdded(title));
      _todoController.clear();
    }
  }
}