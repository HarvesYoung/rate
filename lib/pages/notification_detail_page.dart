import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NotificationDetailPage extends HookWidget {
  const NotificationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // receive the router parameter
    final args = ModalRoute.of(context)?.settings.arguments as num;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(5),
        color: Colors.grey.shade50,
        child: FutureBuilder(
          future: _fetchDetail(),
          builder: (_, AsyncSnapshot snapshot) {
            if(snapshot.hasError) {
              return Text('load failed!');
            }

            if(snapshot.connectionState == ConnectionState.done) {
              return Text('Num = $args');
            } else {
              return Text('waiting');
            }
          },
        )
      )
    );
  }

  Future<void> _fetchDetail() async {
    await Future.delayed(const Duration(seconds: 1));
  } // _fetchDetail() end

}