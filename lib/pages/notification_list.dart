import 'package:flutter/material.dart';


class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NotificationList'),
        ),
        body: Container(
          padding: EdgeInsets.all(5),
          child: const Text('NotificationList'),
        )
    );
  }
}