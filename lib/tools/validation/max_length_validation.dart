import 'package:otobus_app/tools/validation/validation_rule.dart';

class MaxLengthValidation extends ValidationRule {
  final int _maxLength;
  int get maxLength => _maxLength;

  MaxLengthValidation({required int maxLength, required String errorMessage})
      : _maxLength = maxLength,
        super(errorMessage: errorMessage);

  @override
  String? run(String inputString) {
    if (inputString.length > maxLength) {
      return errorMessage;
    }
    return null;
  }
}
