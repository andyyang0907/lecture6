import 'package:flutter/material.dart';

// 自主实践（一）：任务1 对齐任务卡 + 任务2 弹性分配实验
class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自主实践（一）')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle('任务 1 · 对齐任务卡：六种对齐场景'),
          _AlignDemo(
            title: '1. Row · mainAxisAlignment.start',
            mainAxis: MainAxisAlignment.start,
          ),
          _AlignDemo(
            title: '2. Row · mainAxisAlignment.center',
            mainAxis: MainAxisAlignment.center,
          ),
          _AlignDemo(
            title: '3. Row · mainAxisAlignment.spaceBetween',
            mainAxis: MainAxisAlignment.spaceBetween,
          ),
          _AlignDemo(
            title: '4. Row · mainAxisAlignment.spaceAround',
            mainAxis: MainAxisAlignment.spaceAround,
          ),
          _AlignDemo(
            title: '5. Row · mainAxisAlignment.spaceEvenly',
            mainAxis: MainAxisAlignment.spaceEvenly,
          ),
          _AlignDemo(
            title:
                '6. Row · mainAxisAlignment.end\n    + crossAxisAlignment.end',
            mainAxis: MainAxisAlignment.end,
            crossAxis: CrossAxisAlignment.end,
            height: 90,
          ),
          SizedBox(height: 24),
          _SectionTitle('任务 2 · 弹性分配实验：比例 + 超长内容'),
          _FlexDemo(flexes: [2, 1, 1], label: '场景 A：2:1:1 正常分配'),
          SizedBox(height: 16),
          _FlexDemo(flexes: [1, 2, 1], label: '场景 B：1:2:1 正常分配'),
          SizedBox(height: 16),
          _FlexDemo(
            flexes: [2, 1, 1],
            withLongContent: true,
            label: '场景 C：2:1:1 + 中间栏内容超长',
          ),
          SizedBox(height: 8),
          Text(
            '现象记录：中间栏内容超长时，Expanded 把宽度约束强制发给子组件，'
            '文字在栏内自动换行、整行被撑高，没有出现 RenderFlex 溢出警告——'
            '因为溢出的前提是"子组件按内容报尺寸"，而 Expanded 收回了这个权利。',
            style: TextStyle(fontSize: 13, color: Colors.black54),
          ),
          SizedBox(height: 24),
          _SectionTitle('任务 3 · 层叠角标：Stack + Positioned'),
          _BadgeDemos(),
          SizedBox(height: 24),
          _SectionTitle('任务 4 · 容器美化四件套：圆角 / 边框 / 渐变 / 阴影'),
          _DecorationDemo(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// 单个对齐演示卡：标题即参数标注，灰底容器内放三个色块观察对齐效果
class _AlignDemo extends StatelessWidget {
  final String title;
  final MainAxisAlignment mainAxis;
  final CrossAxisAlignment crossAxis;
  final double height;

  const _AlignDemo({
    required this.title,
    required this.mainAxis,
    this.crossAxis = CrossAxisAlignment.center,
    this.height = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
            ),
            const SizedBox(height: 8),
            Container(
              height: height,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: mainAxis,
                crossAxisAlignment: crossAxis,
                children: const [
                  _DemoBox(Colors.blue),
                  _DemoBox(Colors.green),
                  _DemoBox(Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoBox extends StatelessWidget {
  final Color color;

  const _DemoBox(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(width: 40, height: 40, color: color);
  }
}

// 弹性分配实验：flexes 指定三栏比例；withLongContent 时中间栏放超长文字
class _FlexDemo extends StatelessWidget {
  final List<int> flexes;
  final String label;
  final bool withLongContent;

  const _FlexDemo({
    required this.flexes,
    required this.label,
    this.withLongContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.orange.shade200,
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < 3; i++)
                  Expanded(
                    flex: flexes[i],
                    child: Container(
                      height: withLongContent && i == 1 ? null : 60,
                      color: colors[i],
                      padding: const EdgeInsets.all(4),
                      alignment: withLongContent && i == 1
                          ? Alignment.topLeft
                          : Alignment.center,
                      child: Text(
                        withLongContent && i == 1
                            ? 'flex: ${flexes[i]} 超长内容超长内容超长内容超长内容超长内容超长内容'
                            : 'flex: ${flexes[i]}',
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 任务 3：三个层叠角标场景（在线点 / 消息数字角标 / 图片浮层文字）
class _BadgeDemos extends StatelessWidget {
  const _BadgeDemos();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Wrap(
          spacing: 32,
          runSpacing: 16,
          children: [
            // 场景 1：头像在线点
            _LabeledBadge(
              label: '头像在线点\nPositioned(right:0, bottom:0)',
              badge: Stack(
                children: [
                  CircleAvatar(radius: 28, child: Icon(Icons.person)),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _Dot(color: Colors.green, size: 14),
                  ),
                ],
              ),
            ),
            // 场景 2：消息数字角标（超出边界用 clipBehavior: Clip.none）
            _LabeledBadge(
              label: '消息数字角标\nPositioned(right:-6, top:-6)',
              badge: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications, size: 40, color: Colors.blueGrey),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: _CountBadge(count: '3'),
                  ),
                ],
              ),
            ),
            // 场景 3：图片浮层文字（渐变色块代替网络图片，规避来源合规问题）
            _LabeledBadge(
              label: '图片浮层文字\nPositioned(left:8, bottom:8)',
              badge: Stack(
                children: [
                  _FakeImage(),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: Text(
                      '山涧晨光',
                      style: TextStyle(color: Colors.white, fontSize: 12),
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
}

class _LabeledBadge extends StatelessWidget {
  final Widget badge;
  final String label;

  const _LabeledBadge({required this.badge, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 120, height: 70, child: Center(child: badge)),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;

  const _Dot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: const Border.fromBorderSide(
          BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final String count;

  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

class _FakeImage extends StatelessWidget {
  const _FakeImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 70,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4A6FA5), Color(0xFF27D2BF)],
        ),
      ),
    );
  }
}

// 任务 4：容器美化四件套，两张卡分别演示 圆角+阴影 与 渐变+边框
class _DecorationDemo extends StatelessWidget {
  const _DecorationDemo();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '卡 A：圆角 + 阴影',
              style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text('borderRadius: 12 · boxShadow 偏移(0,2)'),
            ),
            const SizedBox(height: 16),
            const Text(
              '卡 B：渐变 + 边框',
              style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  colors: [Color(0xFF4A6FA5), Color(0xFF27D2BF)],
                ),
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFF2C4A73), width: 2),
                ),
              ),
              child: const Text(
                'LinearGradient 渐变 · Border 2px 描边',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
