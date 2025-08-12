import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.themeData,
            home: ProviderExampleScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class ProviderExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 示例'),
        backgroundColor: Colors.orange,
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
            _buildCounterSection(),
            SizedBox(height: 20),
            _buildUserSection(),
            SizedBox(height: 20),
            _buildThemeSection(),
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
                Icon(Icons.info, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Provider 特点',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              '• 依赖注入和状态管理\n'
              '• 状态可以跨Widget共享\n'
              '• 支持多个Provider\n'
              '• Consumer和Selector优化性能\n'
              '• 支持异步状态管理',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterSection() {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  '计数器示例 (Provider)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${counterProvider.count}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  counterProvider.message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: counterProvider.decrement,
                      icon: Icon(Icons.remove),
                      label: Text('减少'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: counterProvider.reset,
                      icon: Icon(Icons.refresh),
                      label: Text('重置'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: counterProvider.increment,
                      icon: Icon(Icons.add),
                      label: Text('增加'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
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

  Widget _buildUserSection() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
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
                    color: userProvider.isLoggedIn 
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            userProvider.isLoggedIn ? Icons.person : Icons.person_outline,
                            color: userProvider.isLoggedIn ? Colors.green : Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            userProvider.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (userProvider.isLoggedIn) ...[
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.green),
                            SizedBox(width: 8),
                            Text(userProvider.email),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 16),
                if (!userProvider.isLoggedIn)
                  ElevatedButton.icon(
                    onPressed: () => userProvider.login('张三', 'zhangsan@example.com'),
                    icon: Icon(Icons.login),
                    label: Text('登录'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: userProvider.logout,
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
      },
    );
  }

  Widget _buildThemeSection() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
                      value: themeProvider.isDarkMode,
                      onChanged: (_) => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('主题颜色'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(context, Colors.blue, themeProvider),
                    _buildColorButton(context, Colors.red, themeProvider),
                    _buildColorButton(context, Colors.green, themeProvider),
                    _buildColorButton(context, Colors.purple, themeProvider),
                    _buildColorButton(context, Colors.orange, themeProvider),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(BuildContext context, Color color, ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: () => themeProvider.changePrimaryColor(color),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: themeProvider.primaryColor == color
              ? Border.all(color: Colors.white, width: 3)
              : null,
        ),
        child: themeProvider.primaryColor == color
            ? Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildHistorySection() {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
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
                      '操作历史',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (counterProvider.history.isNotEmpty)
                      TextButton(
                        onPressed: counterProvider.clearHistory,
                        child: Text('清除'),
                      ),
                  ],
                ),
                SizedBox(height: 16),
                if (counterProvider.history.isEmpty)
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
                    itemCount: counterProvider.history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.history, size: 20),
                        title: Text(
                          counterProvider.history[index],
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
}