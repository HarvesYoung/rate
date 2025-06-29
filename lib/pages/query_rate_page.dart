import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rate/widgets/widgets.dart';
import 'package:rate/providers/providers.dart';
import 'package:rate/models/models.dart';
import 'package:rate/configs/configs.dart';

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
          // if(!context.mounted) return;
          ref.read(targetInfoStateNotifierProvider.notifier).setInitialText(resp.targetNumber);
          ref.read(sourceInfoStateNotifierProvider.notifier).setInitialText(AppConfig.initialFormatter);
          ref.read(exchangeResponseStateProvider.notifier).state = resp;
          ref.read(isReadonlyStateProvider.notifier).state = false;
        } catch(e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade50,
            textColor: Colors.red,
            timeInSecForIosWeb: 1,
            webPosition: 'center',
            fontSize: 12.0
          );
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
              SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 344,
                        child: BuildTextFieldWidget(
                          textEditingController: sourceCurrentController,
                          currencyDataModel: sourceInfo,
                          isReadonly: isReadonly,
                          handleOnChange: (String cnt) {
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
                      ),
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(sourceInfoStateNotifierProvider.notifier).updateModelInfo(sourceInfo.copyWith(
                            name: targetInfo.name,
                            code: targetInfo.code,
                            currency: targetInfo.currency,
                            continentPos: targetInfo.continentPos,
                            countryPos: targetInfo.countryPos,
                            initialText: targetInfo.initialText
                          ));

                          ref.read(targetInfoStateNotifierProvider.notifier).updateModelInfo(targetInfo.copyWith(
                            name: sourceInfo.name,
                            code: sourceInfo.code,
                            currency: sourceInfo.currency,
                            continentPos: sourceInfo.continentPos,
                            countryPos: sourceInfo.countryPos,
                            initialText: sourceInfo.initialText
                          ));

                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Icon(Icons.swap_vert_outlined, size: 36, color: Colors.black54),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 344,
                        child: BuildTextFieldWidget(
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
                      ),
                    ),
                  ],
                ),
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

      ref.read(targetInfoStateNotifierProvider.notifier).setInitialText(resp.targetNumber);
      ref.read(exchangeResponseStateProvider.notifier).state = resp;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red.shade50,
        textColor: Colors.red,
        timeInSecForIosWeb: 1,
        webPosition: 'center',
        fontSize: 12.0
      );
    } finally {
      ref.read(isReadonlyStateProvider.notifier).state = false;
    }
  } // _handleShowPicker() end
}