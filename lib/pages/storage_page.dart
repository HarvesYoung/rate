import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => StoragePageState();
}

class StoragePageState extends State<StoragePage> {

  final appStorageColor = Colors.red;
  final deviceStorageColor = Colors.orange;
  final deviceEmptyStorageColor = Color(0xFFF5F5F5);
  final TextStyle colorTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 14
  );

  bool _hasCache = false;

  int _cacheSize = 0;
  int _appSize = 0;

  @override
  void initState() {
    super.initState();
    _loadAppStoreSize();
    _getCacheSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('ストレージ'),
      ),
      body: Container(
        color: Color(0xFFF5F5F5),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              height: 200,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                              color: appStorageColor
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: deviceStorageColor
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 74,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
                              color: deviceEmptyStorageColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: appStorageColor,
                          shape: BoxShape.circle
                        ),
                      ),
                      Text('App占用空间', style: colorTextStyle)
                    ],
                  ),

                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: deviceStorageColor,
                            shape: BoxShape.circle
                        ),
                      ),
                      Text('设备使用空间', style: colorTextStyle)
                    ],
                  ),

                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: deviceEmptyStorageColor,
                          shape: BoxShape.circle
                        ),
                      ),
                      Text('设备剩余空间', style: colorTextStyle)
                    ],
                  ),

                  const SizedBox(height: 25,),
                  Row(
                    children: [
                      const Text('App占用空间', style: TextStyle(
                          fontSize: 14
                      ),)
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(_formatSize(_appSize), style: TextStyle(
                          fontSize: 24
                      ),)
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 10,),
            Container(
              height: 100,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Cache', style: TextStyle(
                                fontSize: 14
                            )),
                            Text(_formatSize(_cacheSize), style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 56,
                        height: 28,
                        child: GestureDetector(
                          onTap: _clearCache,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _hasCache ? Colors.red : Colors.white,
                              border: Border.all(
                                color: _hasCache ? Colors.red : Colors.grey.shade300,
                                width: 1
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text('クリア', style: TextStyle(
                                  fontSize: 12,
                                  color: _hasCache ?  Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  } // build() end

  Future<int> _getDirectorySize(Directory dir) async {
    int size = 0;
    try {
      if(await dir.exists()) {
        await for (var file in dir.list(recursive: true, followLinks: false)) {
          if(file is File) {
            size += await file.length();
          }
        }
      }
    } catch(e) {
      rethrow;
    }
    return size;
  } // _getDirectorySize() end


  Future<void> _loadAppStoreSize() async {
    try {
      final Directory appDir = await getApplicationSupportDirectory(); // ios: NSApplicationSupportDirectory
      final int size = await _getDirectorySize(appDir);

      setState(() => _appSize = size);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "读取失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.white,
        fontSize: 12.0
      );
    } // getAppStoreSize() end
  }

  /// - calculate the size of application
  /// - @param [int] bytes
  /// - @return [String]
  String _formatSize(int bytes) {
    final double mb = bytes / pow(1024, 2);
    if(mb < 1) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${mb.toStringAsFixed(1)} MB';
  } // _formatSize() end

  Future<void> _clearCache() async {
    try {
      // find the temporary folder
      final tempDir = await getTemporaryDirectory();
      await _deleteDirectory(tempDir);

      // (可选) 获取支持目录
      // final supportDir = await getApplicationSupportDirectory();
      // await _deleteDirectory(supportDir);

      setState(() {
        _hasCache = false;
      });
      await _getCacheSize();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "读取失败, 请稍后再试~~",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red.shade200,
        textColor: Colors.white,
        fontSize: 12.0
      );
    }
  } // _clearCache() end


  Future<void> _deleteDirectory(Directory dir) async {
    if(await dir.exists()) {
      try {
        await dir.delete(recursive: true);
      } catch (e) {
        rethrow;
      }
    }
  } // _deleteDirectory() end

  Future<int> _getCacheSize() async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final size = await _getDirectorySize(tempDir);
      debugPrint('size = $size');
      if(size > 0) {
        setState(() {
          _hasCache = true;
        });
      }
      setState(() {
        _cacheSize = size;
      });
      return size;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "error~~",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade200,
          textColor: Colors.white,
          fontSize: 12.0
      );
      return 0;
    }
  } // _getCacheSize() end
}
