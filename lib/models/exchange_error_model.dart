
class ExchangeErrorModel {
  final bool success;
  final ResponseError error;

  const ExchangeErrorModel({
    required this.success,
    required this.error
  });


  factory ExchangeErrorModel.fromJson(Map<String, dynamic> json) {
    return ExchangeErrorModel(
      success: json['success'],
      error: json['error']
    );
  }
}



class ResponseError {
  final int code;
  final String info;


  const ResponseError({
    required this.code,
    required this.info
  });


  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError(
      code: json['error'],
      info: json['info']
    );
  }
}