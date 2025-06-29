import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/l10n/generated/app_localizations.dart';
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
        selectedItemColor: Colors.purpleAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            activeIcon: Icon(Icons.currency_exchange, color: Colors.purpleAccent,),
            label: AppLocalizations.of(context)!.rate,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              activeIcon: Icon(Icons.person_2, color: Colors.purpleAccent,),
              label: AppLocalizations.of(context)!.me
          ),
        ],
      ),
    );
  }
}