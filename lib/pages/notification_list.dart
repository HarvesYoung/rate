import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class NotificationList extends HookWidget {
  const NotificationList({super.key});


  @override
  Widget build(BuildContext context) {
    final notificationList = useState<Future<List<String>>?>(null);

    useEffect((){
      notificationList.value = _fetchNotificationList();
      return null;
    }, []);

    return Scaffold(
        appBar: AppBar(
          title: const Text('notification list'),
        ),
        // body: Container(
        //   padding: EdgeInsets.all(5),
        //   child: ListView(
        //     children: [
        //       GestureDetector(
        //         onTap: () {
        //           debugPrint('onTap');
        //         },
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.all(Radius.circular(5))
        //           ),
        //           child: ListTile(
        //             leading: Icon(Icons.add_a_photo),
        //             title: const Text('hello'),
        //           ),
        //         ),
        //       )
        //     ],
        //   )
        // )

      body: FutureBuilder(
        future: notificationList.value,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError) {
              return Text('has error');
            } else if(snapshot.hasData) {
              return const Text('ok');
            }
          } else {
            return const Text('加载····');
          }
          return Text('status');
        },
      ),
    );
  } // build() end


  Future<List<String>> _fetchNotificationList() async {
    return await Future.delayed(const Duration(seconds: 1), () {
      debugPrint('delayed');
      return ['title A', 'title B'];
    });
  } // _fetchNotificationData() end
}