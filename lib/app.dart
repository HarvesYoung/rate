import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/configs/custom_navigation_bar_items_config.dart';
import 'package:rate/pages/my_page.dart';
import 'package:rate/pages/query_rate_page.dart';

class App extends HookWidget {
  const App({super.key});

  final List<Widget> _pages = const [
    QueryRatePage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {

    final activeIndex = useState(0);
    final pageController = usePageController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: activeIndex.value,
          onTap: (int pos) {
            activeIndex.value = pos;
            pageController.jumpToPage(pos);
          },
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.purpleAccent,
          items: customNavigationBarItemsConfig,
        ),
      ),
    );
  }
}