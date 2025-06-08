import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate/models/currency_data_model.dart';
import 'package:rate/utils/continents.dart';
import 'package:rate/utils/countries.dart';

class CurrencyPickerModelWidget extends HookConsumerWidget {

  final CurrencyDataModel currencyDataParam;

  const CurrencyPickerModelWidget({super.key, required this.currencyDataParam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final continentIndex = useState(currencyDataParam.continentPos);
    final countryIndex = useState(currencyDataParam.countryPos);

    final countryList = continentList[continentIndex.value];

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: currencyDataParam.continentPos),
                    itemExtent: 40,
                    onSelectedItemChanged: (int i) {
                      countryIndex.value = 0;
                      continentIndex.value = i;
                    },
                    children: List<Widget>.generate(
                        continentsOfEnglishVersion.length,
                        (int i) {
                          return Center(
                            child: Text(continentsOfEnglishVersion[i], style: TextStyle(
                              fontSize: 18
                            )),
                          );
                        }
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(initialItem: currencyDataParam.countryPos),
                    itemExtent: 40,
                    onSelectedItemChanged: (int i) {
                      countryIndex.value = i;
                    },
                    children: List<Widget>.generate(
                      countryList.length,
                      (int i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15,),
                            Image.asset('assets/flags/${countryList[i]['code']}.png'),
                            const SizedBox(width: 15,),
                            Text(countryList[i]['name']!, style: TextStyle(
                              fontSize: 16
                            ),),
                          ],
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.check, color: Colors.blue,),
              onPressed: () {

                debugPrint('current continent index = ${continentIndex.value}');
                final country = continentList[continentIndex.value][countryIndex.value];
                debugPrint('current country  = $country');

                Navigator.pop(context, currencyDataParam.copyWith(
                  name: country['name']!,
                  code: country['code']!,
                  currency: country['currency']!,
                  continentPos: continentIndex.value,
                  countryPos: countryIndex.value
                ));
              },
            ),
          )
        ],
      ),
    );
  } // build() end
}