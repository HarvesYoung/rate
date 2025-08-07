import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rate/configs/app_config.dart';

///  ---------------------
/// Firestore 操作服务类：用于统一管理对 Cloud Firestore 的读写
// ✅ 单例模式的写法：
//  ---------------------
class CloudFirestoreService {

  // 静态私有变量，保存当前类的唯一实例（懒汉式单例）
  static final CloudFirestoreService _instance = CloudFirestoreService._internal();

  // 工厂构造方法：每次调用 CloudFirestoreService() 都返回同一个实例
  factory CloudFirestoreService() => _instance;

  // 私有的命名构造函数，禁止外部直接实例化
  CloudFirestoreService._internal();

  /// ---------------------
  /// Firestore 实例对象
  /// ---------------------
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ---------------------
  /// 添加反馈数据到 Firestore
  /// - 参数 [item]：反馈数据，类型是 Map&ltString, dynamic&gt
  /// - 自动添加创建时间字段：createdAt（使用服务器时间）
  /// - 异常时打印错误日志并重新抛出
  /// ---------------------
  Future<void> addFeedback (Map<String, dynamic> item) async {
    try {
      // 添加创建时间字段，使用服务器时间（避免设备时间不准）
      item['createdAt'] = FieldValue.serverTimestamp();
      await _db.collection(AppConfig.feedbackCollectionName).add(item);
    } on FirebaseException catch (e) {
      debugPrint('Exception ${e.code} : ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      rethrow;
    }
  } // addFeedback() end
}