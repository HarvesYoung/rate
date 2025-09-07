import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate/services/cloud_firestore_service.dart';

/// not used
final notificationFutureProvider = FutureProvider((ref) async {
  final service = CloudFirestoreService();
  return await service.fetchNotificationList();
});