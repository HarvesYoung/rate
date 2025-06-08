
import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> customNavigationBarItemsConfig = [
  BottomNavigationBarItem(
    icon: Icon(Icons.currency_exchange),
    activeIcon: Icon(Icons.currency_exchange, color: Colors.purpleAccent,),
    label: '汇率',
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      activeIcon: Icon(Icons.person_2, color: Colors.purpleAccent,),
      label: '我'
  ),
];