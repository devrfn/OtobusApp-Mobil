import 'package:otobus_app/tools/validation/validation_rule.dart';

class EmailFormatValidation extends ValidationRule {
  EmailFormatValidation({required super.errorMessage});

  @override
  String? run(String inputString) {
    if (!inputString.contains("@")) {
      print("inputString - if block");
      return errorMessage;
    }
    return null;
  }
}
