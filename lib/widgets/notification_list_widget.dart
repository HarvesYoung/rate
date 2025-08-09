import 'package:flutter/material.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                debugPrint('onTap');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: ListTile(
                  leading: Icon(Icons.add_a_photo),
                  title: const Text('hello'),
                ),
              ),
            )
          ],
        )
    );
  } // build() end
}