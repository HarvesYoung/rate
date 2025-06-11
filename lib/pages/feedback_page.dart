import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FeedbackPage extends HookWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {

    final imageLength = useState(0);
    final isSubmitInfoComplete = useState(false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
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

            const Text('反馈信息'),

            const SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 10),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: TextFormField(
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

            const Text('图片'),

            const SizedBox(height: 10,),

            Container(
              height: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Row(
                children: [
                  // todo display picked image

                  if(imageLength.value < 3)SizedBox(
                    height: 80,
                    width: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey.shade200
                      ),
                      child: Center(
                        child: const Icon(Icons.add),
                      )
                    )
                  )
                ],
              ),
            ),

            const SizedBox(height: 50,),

            OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: BorderSide.none,
                backgroundColor: isSubmitInfoComplete.value ? Colors.redAccent : Colors.grey.shade200
              ),
              child: Text('Submit', style: isSubmitInfoComplete.value ? TextStyle(color: Colors.white) : null),
            )
          ],
        )
      )
    );
  }
}
