import 'package:otobus_app/tools/validation/validation_rule.dart';

class EmptyValidation extends ValidationRule {
  EmptyValidation({required String errorMessage})
      : super(errorMessage: errorMessage);

  @override
  String? run(String inputString) {
    if (inputString.isEmpty) {
      return errorMessage;
    }
    return null;
  }
}
