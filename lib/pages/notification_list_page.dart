import 'package:flutter/material.dart';
import 'package:rate/widgets/widgets.dart';
import 'package:rate/models/models.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => NotificationListPageState();
}

class NotificationListPageState extends State<NotificationListPage> with AutomaticKeepAliveClientMixin {

  late Future<List<NotificationItemModel>> notificationList;

  @override
  void initState() {
    super.initState();
    notificationList = _fetchNotificationList();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('notifications'),
      ),
      body: FutureBuilder(
        future: notificationList,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('has error');
          }
          if(snapshot.connectionState == ConnectionState.done) {
            return NotificationListItemWidget();
          }
          return const NotificationLoadingWidget();
        },
      ),
    );
  } // build() end


  /// load the notification list data
  Future<List<NotificationItemModel>> _fetchNotificationList() async {
    return await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('delayed');
      return [
        NotificationItemModel(title: 'title', subtitle: 'subtitle')
      ];
    });
  }
}

