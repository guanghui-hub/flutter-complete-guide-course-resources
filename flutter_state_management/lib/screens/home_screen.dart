import 'package:flutter/material.dart';

// 导入各种状态管理示例屏幕
import 'stateful_widget_example.dart';
import 'provider_example.dart';
import 'riverpod_example.dart';
import 'bloc_example.dart';
import 'comparison_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 状态管理示例'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildWelcomeCard(),
            SizedBox(height: 20),
            _buildStateManagementCard(
              context,
              title: 'StatefulWidget',
              subtitle: '基础状态管理',
              icon: Icons.widgets,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StatefulWidgetExample()),
              ),
            ),
            _buildStateManagementCard(
              context,
              title: 'Provider',
              subtitle: '依赖注入和状态管理',
              icon: Icons.settings,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProviderExample()),
              ),
            ),
            _buildStateManagementCard(
              context,
              title: 'Riverpod',
              subtitle: '现代化的Provider替代方案',
              icon: Icons.stream,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RiverpodExample()),
              ),
            ),
            _buildStateManagementCard(
              context,
              title: 'Bloc',
              subtitle: 'Business Logic Component',
              icon: Icons.account_tree,
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BlocExample()),
              ),
            ),
            SizedBox(height: 20),
            _buildComparisonCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              Icons.flutter_dash,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(height: 12),
            Text(
              '欢迎学习Flutter状态管理',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '本示例展示了Flutter中常用的状态管理方法',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateManagementCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildComparisonCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.compare_arrows, color: Colors.red, size: 24),
        ),
        title: Text(
          '状态管理对比',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text('查看不同状态管理方法的优缺点'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ComparisonScreen()),
        ),
      ),
    );
  }
}