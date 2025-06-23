import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/providers/providers.dart';
import 'package:rate/services/cloud_firestore_service.dart';
import 'package:rate/services/firebase_storage_service.dart';
import 'package:rate/utils/functions.dart';
import 'package:rate/widgets/widgets.dart';

class FeedbackPage extends HookConsumerWidget {
  FeedbackPage({super.key});

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isSubmitInfoComplete = useState(false);
    final isReadonly = useState(false);
    final textController = useTextEditingController();
    final pickedImages = ref.watch(pickedImageNotifierProvider);

    useEffect((){
      void listener() {
        isSubmitInfoComplete.value = textController.text.trim().isNotEmpty;
      }
      textController.addListener(listener);
      return () {
        textController.removeListener(listener);
      };
    }, [textController]);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if(pickedImages.isEmpty) {
              return Navigator.of(context).pop();
            }

            final shouldExit = await _handleGoBack(context);
            if(!shouldExit) return;
            if(!context.mounted) return;
            // clear all the picked images
            ref.read(pickedImageNotifierProvider.notifier).clearPickedImages();
            Navigator.of(context).pop();
          }
        ),
        title: const Text('フィードバック',
          style: TextStyle(
          fontSize: 16
        ),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView(
          children: [
            Container(
              color: Colors.green,
              height: 100,
            ),
            const SizedBox(height: 15,),

            // const Text('反馈信息'),
            RichText(
              text: TextSpan(
                text: '反馈信息',
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 10),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextFormField(
                readOnly: isReadonly.value,
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter your message...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              )
            ),

            const SizedBox(height: 35,),

            const Text('图片',
                style: TextStyle(color: Colors.black87)
            ),

            const SizedBox(height: 10,),

            Container(
              height: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Row(
                children: [
                  ...pickedImages.map((img) {
                    return GestureDetector(
                      onTap: () => isReadonly.value ? null : _showImageOption(context, ref, img),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.file(
                          File(img.path),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),

                  if(pickedImages.length < AppConfig.feedbackImageLength)SizedBox(
                    height: 80,
                    width: 80,
                    child: GestureDetector(
                      onTap: () async {
                        if(isReadonly.value) return;
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if(image == null) return;

                        final compressedFile = await compressImage(File(image.path));
                        ref.read(pickedImageNotifierProvider.notifier).addPickedImage(compressedFile);
                        ref.read(uploadProgressProvider.notifier).addInitProgress();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade200
                        ),
                        child: Center(
                          child: const Icon(Icons.add),
                        )
                      ),
                    )
                  )
                ],
              ),
            ),

            const SizedBox(height: 50,),

            OutlinedButton(
              // handle submit
              onPressed: !isSubmitInfoComplete.value ? null : () async {
                try {
                  isReadonly.value = true;
                  // await _handleOnSubmit(ref, pickedImages);

                  List<String> downloadUrls = [];

                  // upload picked images
                  if(pickedImages.isNotEmpty) {
                    final storage = FirebaseStorageService();
                    downloadUrls = await storage.uploadMultiImages(files: pickedImages, ref: ref);
                  }

                  final db = CloudFirestoreService();
                  await db.addFeedback({'message':  textController.text, 'downloadUrls': downloadUrls});

                  // clear textForm's content
                  textController.text = '';

                  isReadonly.value = false;

                  // clear all the picked images
                  ref.read(pickedImageNotifierProvider.notifier).clearPickedImages();

                  Fluttertoast.showToast(
                    msg: '提交成功',
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    timeInSecForIosWeb: 2,
                    webPosition: 'center',
                    fontSize: 12.0
                  );
                } on FirebaseException catch (e) {
                  Fluttertoast.showToast(
                    msg: '${e.code}: ${e.message}',
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red.shade50,
                    textColor: Colors.red,
                    timeInSecForIosWeb: 2,
                    webPosition: 'center',
                    fontSize: 12.0
                  );
                } finally {
                  ref.read(uploadProgressProvider.notifier).reset();
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: BorderSide.none,
                backgroundColor: isSubmitInfoComplete.value ? Colors.redAccent : Colors.grey.shade200
              ),
              child: isReadonly.value
                ? CustomProgressPercentWidget()
                : Text('Submit', style: isSubmitInfoComplete.value ? TextStyle(color: Colors.white) : null),
            )
          ],
        )
      )
    );
  } // build() end

  void _showImageOption(BuildContext context, WidgetRef ref, File image) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16)
        )
      ),
      builder: (_) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade100,
                      width: 1
                    )
                  )
                ),
                child: ListTile(
                  title: Center(child: const Text('更改', style: TextStyle(
                    fontSize: 14,
                  ),),),
                  onTap: () async {
                    Navigator.pop(context);

                    final XFile? newPickedImage = await picker.pickImage(source: ImageSource.gallery);
                    if(newPickedImage == null) return;
                    final compressedFile = await compressImage(File(newPickedImage.path));
                    ref.read(pickedImageNotifierProvider.notifier).updatePickedImage(image, compressedFile);
                  },
                ),
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                  title: Center(child: const Text('删除', style: TextStyle(color: Colors.red,fontSize: 14,),),),
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(pickedImageNotifierProvider.notifier).deletePickedImage(image);
                    ref.read(uploadProgressProvider.notifier).removeLastProgress();
                  },
                ),
              ),
              const SizedBox(height: 5,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    title: Center(child: const Text('取消', style: TextStyle(
                      fontSize: 14,
                    ),)),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  } // _showImageOption() end


  Future<bool> _handleGoBack(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text("确认退出吗"),
          content: const Text('确丁要退出该页面吗'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定'),
            )
          ],
        );
      }
    );
  } // handleGoBack() end
}









































