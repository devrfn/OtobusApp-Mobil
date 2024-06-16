class DateTimeTool {
  static String getFormattedDateTimeNow() {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();
    String day = now.day.toString();

    if (month.length == 1) month = "0$month";
    if (day.length == 1) day = "0$day";

    String formattedDate = "$day / $month / $year";
    return formattedDate;
  }

  static String rawDateStringToFormattedDateString(String rawDateString) {
    print(rawDateString);
    try {
      rawDateString = rawDateString.trim();
      var dateAndTime = rawDateString.split(' ');
      var yearMonthDay = dateAndTime[0].split("-");
      String year = yearMonthDay[0];
      String month = yearMonthDay[1];
      String day = yearMonthDay[2];
      String formattedDate = "$day / $month / $year";
      return formattedDate;
    } catch (e) {
      (e.toString());
    }
    return "";
  }

  static String getTimeFromDateTimeString(String dateTimeString) {
    try {
      if (dateTimeString.isNotEmpty) {
        List<String> dateAndTime = dateTimeString.split('T');
        String time = dateAndTime[1];
        return time;
      }
    } catch (e) {
      print(e.toString());
    }
    return dateTimeString;
  }

  static String getDateFromDateTimeString(String dateTimeString) {
    try {
      if (dateTimeString.isNotEmpty) {
        List<String> dateAndTime = dateTimeString.split('T');
        String date = dateAndTime[0];
        return date;
      }
    } catch (e) {
      print(e.toString());
    }
    return dateTimeString;
  }

  static String getHourAndMinute(String time) {
    String hoursAndMinutes = time.substring(0, 5);
    return hoursAndMinutes;
  }
}
