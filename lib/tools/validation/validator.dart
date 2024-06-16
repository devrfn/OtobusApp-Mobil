import 'package:otobus_app/tools/validation/validation_rule.dart';

class Validator {
  static String? run(
      String? inputString, List<ValidationRule>? validationRules) {
    if (inputString != null && validationRules != null) {
      inputString = inputString.trim();
      for (ValidationRule rule in validationRules) {
        String? checked = rule.run(inputString);
        if (checked != null) {
          return checked;
        } 
      }
    }
    return null;
  }
}
