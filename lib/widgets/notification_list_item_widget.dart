import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationListItemWidget extends StatelessWidget {
  NotificationListItemWidget({super.key});

  final _refreshController = RefreshController(initialRefresh: false);
  final List<int> items = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
        ),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  Text("上拉加载");
              }
              else if(mode==LoadStatus.loading){
                body =  CupertinoActivityIndicator();
              }
              else if(mode == LoadStatus.failed){
                body = Text("加载失败！点击重试！");
              }
              else if(mode == LoadStatus.canLoading){
                body = Text("松手,加载更多!");
              }
              else{
                body = Text("没有更多数据了!");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemBuilder: (c, i) {
              return GestureDetector(
                onTap: () {
                  debugPrint('onTap');
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey.shade200
                      )
                    )
                  ),
                  child: ListTile(
                    leading: Icon(Icons.add_a_photo),
                    title: Text('hello ${items[i]}'),
                  ),
                ),
              );
            },
            itemExtent: 100,
            itemCount: items.length,
          ),
        ),
    );
  } // build() end

  void _onRefresh() {
    try {
      // todo load data
      _refreshController.refreshCompleted();
    } catch(e) {
      debugPrint('error message = ${e.hashCode}:${e.toString()}');
      _refreshController.refreshFailed();
    }
  } // _onRefresh() end


  void _onLoading() async {
    try {
      // todo load data
      await Future.delayed(Duration(seconds: 1));
      items.addAll([items.length + 1, items.length + 2]);
      _refreshController.refreshCompleted();
    } catch(e) {
      debugPrint('error message = ${e.hashCode}:${e.toString()}');
      _refreshController.refreshFailed();
    }
  } // _onLoading() end
}