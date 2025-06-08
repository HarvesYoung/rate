

import 'package:rate/configs/app_config.dart';

class CurrencyDataModel {
  final String code;
  final String name;
  final String currency;
  final int continentPos;
  final int countryPos;
  double? initialText;

  CurrencyDataModel({
    required this.name,
    required this.code,
    required this.currency,
    required this.continentPos,
    required this.countryPos,
    this.initialText
  });

  String get formattedInitialText {
    if(initialText != null) {
      return initialText!.toStringAsFixed(AppConfig.fractionDigits);
    }
    return '';
  } // formattedInitialText() end

  factory CurrencyDataModel.fromJson(Map<String, dynamic> json) {
    return CurrencyDataModel(
      name: json['name'],
      code: json['code'],
      currency: json['currency'],
      continentPos: json['continentPos'],
      countryPos: json['countryPos']
    );
  } // CurrencyDataModel.fromJson() end

  CurrencyDataModel copyWith({
    String? name,
    String? code,
    String? currency,
    int? continentPos,
    int? countryPos,
    double? initialText
  }) {
    return CurrencyDataModel(
      name: name ?? this.name,
      code: code ?? this.code,
      currency: currency ?? this.currency,
      continentPos: continentPos ?? this.continentPos,
      countryPos: countryPos ?? this.countryPos,
      initialText: initialText
    );
  } // CurrencyDataModel copyWith() end

  @override
  String toString() {
    return 'initialText = $initialText';
  } // toString() end
} // CurrencyDataModel() end