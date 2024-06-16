import 'package:otobus_app/tools/validation/validation_rule.dart';

class CardDateFormatValidation extends ValidationRule {
  CardDateFormatValidation({required super.errorMessage});

  @override
  String? run(String inputString) {
    try {
      List<String> monthAndYear = inputString.split("/");
      String monthStr = monthAndYear[0];

      int month = int.parse(monthStr);

      // Kart'a girilen ay'ın geçerli bir tarih olup olmadığının kotrolü.
      if (!(month > 0 && month < 13)) {
        return errorMessage;
      }

      return null;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
