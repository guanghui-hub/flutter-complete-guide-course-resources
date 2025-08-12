import 'package:flutter/material.dart';

class ComparisonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理对比'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildIntroCard(),
            SizedBox(height: 20),
            _buildComparisonTable(),
            SizedBox(height: 20),
            _buildDetailedComparison(),
            SizedBox(height: 20),
            _buildRecommendationCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
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
                Icon(Icons.compare_arrows, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  '状态管理方法对比',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Flutter提供了多种状态管理方法，每种都有其适用场景和优缺点。选择合适的状态管理方案对项目的可维护性和性能至关重要。',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '快速对比表',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.grey[300]!, width: 1),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
              },
              children: [
                _buildTableRow(['特性', 'StatefulWidget', 'Provider', 'Riverpod', 'Bloc'], isHeader: true),
                _buildTableRow(['学习曲线', '简单', '中等', '中等', '较难']),
                _buildTableRow(['代码量', '少', '中等', '中等', '多']),
                _buildTableRow(['性能', '一般', '好', '优秀', '好']),
                _buildTableRow(['测试性', '一般', '好', '优秀', '优秀']),
                _buildTableRow(['跨组件共享', '不支持', '支持', '支持', '支持']),
                _buildTableRow(['异步处理', '基础', '支持', '优秀', '优秀']),
                _buildTableRow(['依赖注入', '不支持', '支持', '优秀', '不支持']),
                _buildTableRow(['编译时安全', '一般', '一般', '优秀', '好']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader 
          ? BoxDecoration(color: Colors.grey[200])
          : null,
      children: cells.map((cell) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          cell,
          style: TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: isHeader ? 12 : 11,
          ),
          textAlign: TextAlign.center,
        ),
      )).toList(),
    );
  }

  Widget _buildDetailedComparison() {
    return Column(
      children: [
        _buildMethodCard(
          'StatefulWidget',
          Colors.green,
          Icons.widgets,
          '适用场景：',
          '• 简单的局部状态管理\n• 单个Widget内的状态变化\n• 学习Flutter的入门阶段',
          '优点：',
          '• 简单易懂，学习成本低\n• Flutter内置，无需额外依赖\n• 适合小型应用',
          '缺点：',
          '• 无法跨Widget共享状态\n• 状态与UI耦合严重\n• 难以测试业务逻辑',
        ),
        SizedBox(height: 16),
        _buildMethodCard(
          'Provider',
          Colors.orange,
          Icons.settings,
          '适用场景：',
          '• 中小型应用\n• 需要跨Widget共享状态\n• 团队对状态管理有一定经验',
          '优点：',
          '• 依赖注入和状态管理\n• 性能优化（Consumer/Selector）\n• 社区成熟，文档丰富',
          '缺点：',
          '• 运行时错误风险\n• 复杂状态管理时代码冗长\n• 缺乏编译时安全检查',
        ),
        SizedBox(height: 16),
        _buildMethodCard(
          'Riverpod',
          Colors.purple,
          Icons.stream,
          '适用场景：',
          '• 现代化的Flutter应用\n• 需要强类型安全\n• 复杂的状态依赖关系',
          '优点：',
          '• 编译时安全\n• 优秀的异步支持\n• 自动资源清理\n• 更好的测试支持',
          '缺点：',
          '• 相对较新，生态系统在发展\n• 学习曲线比Provider略陡\n• 迁移成本较高',
        ),
        SizedBox(height: 16),
        _buildMethodCard(
          'Bloc',
          Colors.blue,
          Icons.account_tree,
          '适用场景：',
          '• 大型企业应用\n• 复杂的业务逻辑\n• 需要严格的架构约束',
          '优点：',
          '• 清晰的业务逻辑分离\n• 优秀的测试支持\n• 可预测的状态变化\n• 强大的调试工具',
          '缺点：',
          '• 学习成本高\n• 代码量较多\n• 对简单场景过度设计',
        ),
      ],
    );
  }

  Widget _buildMethodCard(
    String title,
    Color color,
    IconData icon,
    String scenarioTitle,
    String scenarios,
    String prosTitle,
    String pros,
    String consTitle,
    String cons,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSection(scenarioTitle, scenarios, Colors.blue),
            SizedBox(height: 12),
            _buildSection(prosTitle, pros, Colors.green),
            SizedBox(height: 12),
            _buildSection(consTitle, cons, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard() {
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
                Icon(Icons.lightbulb, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  '选择建议',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildRecommendationItem(
              '🚀 初学者 / 简单应用',
              'StatefulWidget',
              '适合学习Flutter基础概念，处理简单的局部状态。',
            ),
            _buildRecommendationItem(
              '🏢 中小型应用',
              'Provider',
              '成熟稳定，社区支持好，适合大多数中小型项目。',
            ),
            _buildRecommendationItem(
              '⚡ 现代化应用',
              'Riverpod',
              '编译时安全，异步支持优秀，适合追求代码质量的项目。',
            ),
            _buildRecommendationItem(
              '🏭 大型企业应用',
              'Bloc',
              '架构清晰，测试友好，适合复杂业务逻辑和团队协作。',
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.amber[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '💡 提示：可以在同一个项目中混合使用不同的状态管理方法，根据具体场景选择最适合的方案。',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String scenario, String method, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              scenario,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}