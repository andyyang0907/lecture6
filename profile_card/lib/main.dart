import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ProfileCardPage(),
    );
  }
}

class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),

          // ① 头像区
          const CircleAvatar(
            radius: 48,
            child: Icon(Icons.person, size: 48),
          ),
          const SizedBox(height: 16),

          // ② 姓名与签名（两行 Text）
          const Text(
            '张三',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Flutter 学习者 | 移动开发实践中',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // ③ 统计条：Row + 三个 Expanded 三等分
          const Row(
            children: [
              Expanded(child: _StatItem(count: '128', label: '动态')),
              Expanded(child: _StatItem(count: '1024', label: '关注者')),
              Expanded(child: _StatItem(count: '56', label: '正在关注')),
            ],
          ),
          const SizedBox(height: 24),

          // ④ 标签云：Wrap 流式排列，放不下自动换行
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Tag(label: 'Flutter'),
              _Tag(label: 'Dart'),
              _Tag(label: '移动开发'),
              _Tag(label: 'UI 设计'),
              _Tag(label: '开源'),
              _Tag(label: '摄影'),
            ],
          ),
        ],
      ),
    );
  }
}

// 统计条单个数字块：上数字、下标签
class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

// 单个标签
class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.blue.shade50,
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}
