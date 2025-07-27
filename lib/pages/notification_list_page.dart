
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListStatePage();
}

class _NotificationListStatePage extends State<NotificationListPage> {

  List<String> notificationList = [];
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false
  );

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if(mode == LoadStatus.idle) {
                body = const Text('pull up load');
              } else if(mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if(mode == LoadStatus.failed) {
                body = const Text('Load failed! Try again');
              } else if(mode == LoadStatus.canLoading) {
                body = const Text('release to load more');
              } else {
                body = const Text('No more data');
              }
              return SizedBox(
                height: 55,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _initialLoad,
          child: SafeArea(
            bottom: true,
            child: ListView.builder(
              itemBuilder: (c, i) {
                // return Card(child: Center(child: Text("Current $i"),),);
                return GestureDetector(
                  onTap: () =>  _handleItemTap(i),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text("Current $i"),
                  ),
                );
              },
              itemCount: 50,
            ),
          ),
        )
      ),
    );
  }

  Future<void> _initialLoad() async {
    return Future.delayed(const Duration(seconds: 1));
  } // _initialLoad() end


  Future<dynamic> _fetchNotificationListFromFirebase() async {
    return Future.delayed(const Duration(seconds: 1), () => 1);
  } // _getNotificationListFromFirebase() end

  // 下拉刷新
  Future<void> _onRefresh() async {
    final moreData = await _fetchNotificationListFromFirebase();
    debugPrint('moreData = $moreData}');
    // todo 更新state
    _refreshController.refreshCompleted();
  } // _onRefresh() end

  void _handleItemTap(num pos) {
    Navigator.of(context).pushNamed('notificationDetail', arguments: pos);
  } // _handleItemTap() end

}