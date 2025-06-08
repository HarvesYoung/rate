
class ExchangeResponseModel {
  bool? success;
  int? timestamp;
  String? base;
  String? date;
  String? targetCurrency;
  double? targetNumber;


  ExchangeResponseModel({
    this.success,
    this.timestamp,
    this.base,
    this.date,
    this.targetCurrency,
    this.targetNumber,
  });

  factory ExchangeResponseModel.fromJson(Map<String, dynamic> json) {
    var entry = json['rates'].entries.first;
    return ExchangeResponseModel(
      success: json['success'],
      timestamp: json['timestamp'],
      base: json['base'],
      date: json['date'],
      targetCurrency: entry.key,
      targetNumber: entry.value,
    );
  } // ExchangeResponseModel.fromJson() end

  @override
  String toString() {
    return "success  = $success, base = $base, date = $date, targetCurrency = $targetCurrency, targetNumber = $targetNumber ;";
  } // toString() end
}