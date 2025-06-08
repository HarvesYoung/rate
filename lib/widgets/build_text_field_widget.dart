
import 'package:flutter/material.dart';
import 'package:rate/models/currency_data_model.dart';

class BuildTextFieldWidget extends StatelessWidget {

  final CurrencyDataModel currencyDataModel;
  final TextEditingController textEditingController;
  final bool isReadonly;
  final Function(String)? handleOnChange;
  final Function()? handleOnTap;

  const BuildTextFieldWidget({
    super.key,
    required this.currencyDataModel,
    required this.textEditingController,
    this.isReadonly = false,
    this.handleOnChange,
    this.handleOnTap
  });

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedSwitcher(
  //     duration: const Duration(milliseconds: 400),
  //     transitionBuilder: (Widget child, Animation<double> animation) {
  //       final isTop = key.toString().contains('source');
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: Offset(0, isTop ? -1.0 : 1.0),
  //           end: Offset.zero
  //         ).animate(animation),
  //         child: child,
  //       );
  //     },
  //     child: _buildAnimatedChild(currencyDataModel.code),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.black12
          )
      ),
      child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                readOnly: isReadonly,
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: handleOnChange,
              ),
            ),
            GestureDetector(
              onTap: handleOnTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/flags/${currencyDataModel.code}.png'),
                  const SizedBox(width: 10,),
                  Text(currencyDataModel.name, style: const TextStyle(
                      color: Colors.black
                  ),),
                  const SizedBox(width: 5,),
                  Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey, size: 22,),
                ],
              ),
            ),
          ],
        ),
    );
  }
}