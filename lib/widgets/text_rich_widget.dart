import 'package:flutter/material.dart';
import 'package:rate/models/exchange_response_model.dart';

class TextRichWidget extends StatelessWidget {
  final ExchangeResponseModel exchangeResponseModel;
  final int fractionDigits;


  const TextRichWidget({
    super.key,
    required this.exchangeResponseModel,
    required this.fractionDigits
  });

  @override
  Widget build(BuildContext context) {

    if(exchangeResponseModel.base == null) {
      return SizedBox();
    }

    return Text.rich(
        TextSpan(
            style: TextStyle(
              fontSize: 22,
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              TextSpan(
                  text: '1.000 ${exchangeResponseModel.base}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
              ),
              TextSpan(
                  text: ' = '
              ),
              TextSpan(
                  text: '${exchangeResponseModel.targetNumber?.toStringAsFixed(fractionDigits)}',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold
                  )
              ),
              TextSpan(
                  text: ' ${exchangeResponseModel.targetCurrency}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
              )
            ]
        )
    );
  }
}
