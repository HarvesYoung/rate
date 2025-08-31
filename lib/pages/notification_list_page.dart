import 'package:flutter/material.dart';
import 'package:rate/widgets/widgets.dart';
import 'package:rate/models/models.dart';
import 'package:rate/services/services.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => NotificationListPageState();
}

class NotificationListPageState extends State<NotificationListPage> with AutomaticKeepAliveClientMixin {

  late Future<List<NotificationItemModel>?> notificationList;

  @override
  void initState() {
    super.initState();
    notificationList = _fetchNotificationList();
    // _fetchNotificationList();
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
      // body: Container(
      //   padding: EdgeInsets.all(10),
      //   child: const Text('notifications list page'),
      // ),
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
  Future<List<NotificationItemModel>?> _fetchNotificationList() async {
    try {

      const List<NotificationItemModel> modelResult = [];

      final instance = CloudFirestoreService();
      final result = await instance.fetchNotificationList(); // Future<List<Map<String, dynamic>>>
      debugPrint('result.length = ${result.length}');
      if(result.isEmpty) return [];
      result.map((doc) {
        final item = NotificationItemModel.fromJson(doc);
        modelResult.add(item);
      });
      return modelResult;
      // return [
      //   NotificationItemModel(title: 'title', subtitle: 'subtitle')
      // ];
    } catch (e) {
      debugPrint('notification_list_page error ${e.toString()}');
    }
    return null;
  } // _fetchNotificationList() end
}

