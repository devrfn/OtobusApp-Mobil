import 'package:otobus_app/tools/validation/validation_rule.dart';

class MinLengthValidation extends ValidationRule {
  final int _minLength;
  int get minLength => _minLength;

  MinLengthValidation({required int minLength, required String errorMessage})
      : _minLength = minLength,
        super(errorMessage: errorMessage);

  @override
  String? run(String inputString) {
    if (inputString.length < minLength) {
      return errorMessage;
    }
    return null;
  }
}
