import 'package:otobus_app/tools/validation/validation_rule.dart';

class CardDateValidation extends ValidationRule {
  CardDateValidation({required super.errorMessage});

  @override
  String? run(String inputString) {
    try {
      List<String> monthAndYear = inputString.split("/");
      String monthStr = monthAndYear[0];
      String yearStr = monthAndYear[1];

      int month = int.parse(monthStr);
      int year = int.parse(yearStr);
      int currentYear = DateTime.now().year;
      int currentMonth = DateTime.now().month;

      // Kartın son kullanma yılı kontrolü.
      if (!(currentYear > year)) {
        return errorMessage;
      }

      // Kartın kullanım ayının ve yılının kontrolü.
      if (currentYear == year && currentMonth >= month) {
        return errorMessage;
      }

      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
