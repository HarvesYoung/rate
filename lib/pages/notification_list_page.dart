import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rate/models/notification_item_model.dart' show NotificationItemModel;
import 'package:rate/providers/notification_future_provider.dart';
import 'package:rate/widgets/notification_list_item_widget.dart';
import 'package:rate/widgets/notification_loading_widget.dart';

class NotificationListPage extends ConsumerWidget {
  const NotificationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(notificationFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('notifications'),
      ),
      body: asyncValue.when(
        data: (items) {
          debugPrint('executed....');
          final modelItems = items.map((doc) => NotificationItemModel.fromJson(doc)).toList();
          return NotificationListItemWidget(items: modelItems);
        },
        loading: () => const NotificationLoadingWidget(),
        error: (error, stack) {
          Fluttertoast.showToast(
            msg: 'error loading notifications',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade200,
          );
          return const Center(child: Text('has error'));
        }
      ),
    );
  }
}