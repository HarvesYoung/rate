import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/configs/custom_navigation_bar_items_config.dart';
import 'package:rate/pages/pages.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  final List<Widget> _pages = const [
    QueryRatePage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    return Scaffold(
      body: IndexedStack(
        index: activeIndex.value,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex.value,
        onTap: (int pos) {
          activeIndex.value = pos;
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: Color(0xFF13227a),
        items: customNavigationBarItemsConfig,
      ),
    );
  }
}