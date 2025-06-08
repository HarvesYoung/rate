import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate/configs/app_config.dart';
import 'package:rate/models/exchange_response_model.dart';

class MarketingTextWidget extends StatelessWidget {
  final ExchangeResponseModel exchangeResponseModel;
  const MarketingTextWidget({super.key, required this.exchangeResponseModel});

  @override
  Widget build(BuildContext context) {
    if(exchangeResponseModel.timestamp == null) {
      return SizedBox();
    }

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(exchangeResponseModel.timestamp! * 1000);
    String formattedTime = DateFormat(AppConfig.formattedDateTime).format(dateTime);

    return Row(
      children: [
        Icon(Icons.info, color: Colors.black45, size: 12,),
        const SizedBox(width: 3,),
        Text('$formattedTime UTC 中间市场汇率', style: TextStyle(
            color: Colors.black45,
            fontSize: 12
        ),),
      ],
    );
  }
}
