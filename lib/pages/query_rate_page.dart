import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/models/currency_data_model.dart';
import 'package:rate/providers/exchange_response_provider.dart';
import 'package:rate/providers/rate_state_notifier_provider.dart';
import 'package:rate/providers/source_info_state_notifier_provider.dart';
import 'package:rate/providers/target_info_state_notifier_provider.dart';
import 'package:rate/widgets/build_text_field_widget.dart';
import 'package:rate/widgets/currency_picker_model_widget.dart';
import 'package:rate/providers/is_readonly_state_provider.dart';
import 'package:rate/widgets/marketing_text_widget.dart';
import 'package:rate/widgets/shimmer_row_widget.dart';
import 'package:rate/widgets/text_rich_widget.dart';

class QueryRatePage extends HookConsumerWidget {
  const QueryRatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final sourceInfo = ref.watch(sourceInfoStateNotifierProvider);
    final targetInfo = ref.watch(targetInfoStateNotifierProvider);

    final isReadonly = ref.watch(isReadonlyStateProvider);
    final exchangeResponse = ref.watch(exchangeResponseStateProvider);

    final sourceCurrentController = useTextEditingController(text: sourceInfo.formattedInitialText);
    final targetCurrentController = useTextEditingController(text: targetInfo.formattedInitialText);


    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          ref.read(isReadonlyStateProvider.notifier).state = true;
          // send http request
          final resp = await ref.read(rateStateNotifierProvider.notifier).fetchRate(
              ref.watch(targetInfoStateNotifierProvider).currency
          );
          // ref.read(targetInfoProvider.notifier).state.initialText = resp.targetNumber;
          /// 从final targetInfoProvider = StateProvider<CurrencyDataModel>()
          /// 改为final targetInfoProvider = StateNotifierProvider<CurrencyDataNotifier, CurrencyDataModel>()
          ref.read(targetInfoStateNotifierProvider.notifier).setInitialText(resp.targetNumber);
          ref.read(sourceInfoStateNotifierProvider.notifier).setInitialText(AppConfig.initialFormatter);
          ref.read(exchangeResponseStateProvider.notifier).state = resp;
        } catch(e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade50,
            textColor: Colors.red,
            timeInSecForIosWeb: 30,
            webPosition: 'center',
            fontSize: 12.0
          );
        } finally {
          ref.read(isReadonlyStateProvider.notifier).state = false;
        }
      });
      return null;
    }, []);

    useEffect(() {
      targetCurrentController.text = targetInfo.formattedInitialText;
      return null;
    }, [targetInfo]);

    useEffect(() {
      sourceCurrentController.text = sourceInfo.formattedInitialText;
      return null;
    }, [sourceInfo]);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [

              BuildTextFieldWidget(
                textEditingController: sourceCurrentController,
                currencyDataModel: sourceInfo,
                isReadonly: isReadonly,
                handleOnChange: (String cnt) {
                  debugPrint('sourceInfo String = $cnt');
                  double? d = double.tryParse(cnt);
                  if(d == null) {
                    return targetCurrentController.text = '';
                  }
                  if(exchangeResponse.targetNumber == null || cnt.isEmpty) {
                    return targetCurrentController.text = '';
                  }
                  targetCurrentController.text = (d * exchangeResponse.targetNumber!).toStringAsFixed(AppConfig.fractionDigits);
                },
                handleOnTap: () {
                  _handleShowPicker(context, ref, data: sourceInfo, isSource: true);
                },
              ),

              const SizedBox(height: 5,),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              const SizedBox(height: 5,),

              BuildTextFieldWidget(
                textEditingController: targetCurrentController,
                currencyDataModel: targetInfo,
                isReadonly: isReadonly,
                handleOnChange: (String cnt) {
                  double? d = double.tryParse(cnt);
                  if(d == null) {
                    sourceCurrentController.text = '';
                  }
                  if(exchangeResponse.targetNumber == null || cnt.isEmpty) {
                    return sourceCurrentController.text = '';
                  }
                  sourceCurrentController.text = (d! / exchangeResponse.targetNumber!).toStringAsFixed(AppConfig.fractionDigits);
                },
                handleOnTap: () {
                  _handleShowPicker(context, ref, data: targetInfo, isSource: false);
                },
              ),

              const SizedBox(height: 20,),

              isReadonly
              ? const ShimmerRowWidget(width: 250, height: 31)
              : TextRichWidget(exchangeResponseModel: exchangeResponse, fractionDigits: AppConfig.fractionDigits),

              const SizedBox(height: 5,),

              isReadonly
              ? const ShimmerRowWidget(width: 150, height: 31)
              : MarketingTextWidget(exchangeResponseModel: exchangeResponse,),
            ]
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          splashColor: Colors.transparent,
          highlightElevation: 0,
          backgroundColor: Colors.transparent,
          child: Icon(Icons.swap_vert_outlined, size: 48, color: Colors.grey.shade500),
          onPressed: () {

            // ref.read(sourceInfoProvider.notifier).state = sourceInfo.copyWith(
            //   name: targetInfo.name,
            //   code: targetInfo.code,
            //   currency: targetInfo.currency,
            //   continentPos: targetInfo.continentPos,
            //   countryPos: targetInfo.countryPos
            // );
            ref.read(sourceInfoStateNotifierProvider.notifier).updateModelInfo(sourceInfo.copyWith(
              name: targetInfo.name,
              code: targetInfo.code,
              currency: targetInfo.currency,
              continentPos: targetInfo.continentPos,
              countryPos: targetInfo.countryPos,
              initialText: targetInfo.initialText
            ));

            // ref.read(targetInfoProvider.notifier).state = targetInfo.copyWith(
            //   name: sourceInfo.name,
            //   code: sourceInfo.code,
            //   currency: sourceInfo.currency,
            //   continentPos: sourceInfo.continentPos,
            //   countryPos: sourceInfo.countryPos
            // );

            ref.read(targetInfoStateNotifierProvider.notifier).updateModelInfo(targetInfo.copyWith(
              name: sourceInfo.name,
              code: sourceInfo.code,
              currency: sourceInfo.currency,
              continentPos: sourceInfo.continentPos,
              countryPos: sourceInfo.countryPos,
              initialText: sourceInfo.initialText
            ));

          },
        ),
      ),
    );
  } // build() end


  /// switch input's value
  /// @param v {String?}
  /// @return void
  void handleTextFormFieldChange(String? v) {
    debugPrint(v);
  } // handleTextFormFieldChange() end


  void _handleShowPicker(BuildContext context, WidgetRef ref,
      {
        required CurrencyDataModel data,
        required bool isSource
      }) async {

    try {
      FocusScope.of(context).unfocus();
      final result = await showModalBottomSheet<CurrencyDataModel>(
          context: context,
          builder: (_) => CurrencyPickerModelWidget(
            currencyDataParam: data,
          )
      );
      if (result == null) return;

      final provider = isSource ? sourceInfoStateNotifierProvider : targetInfoStateNotifierProvider;

      if (result.name == data.name) {
        debugPrint('The same country!');
        return;
      }

      ref.read(provider.notifier).updateModelInfo(result);
      ref.read(isReadonlyStateProvider.notifier).state = true;

      // send http request
      final resp = await ref.read(rateStateNotifierProvider.notifier).fetchRate(
          ref.watch(targetInfoStateNotifierProvider).currency
      );

      ref.read(exchangeResponseStateProvider.notifier).state = resp;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red.shade50,
        textColor: Colors.red,
        timeInSecForIosWeb: 3,
        webPosition: 'center',
        fontSize: 12.0
      );
    } finally {
      ref.read(isReadonlyStateProvider.notifier).state = false;
    }
  } // _handleShowPicker() end
}