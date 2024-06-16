import 'dart:developer' as developer;


class devLog {

  static void log(dynamic msg, {String? where}) {
    where = where == null ? "" : "> $where";
    developer.log("$where ___ $msg");
  }

  static void logInfo(dynamic msg, {String? where}) {
    where = where == null ? "" : "> $where";
    developer.log('\x1B[34m $where ___ $msg \x1B[0m');
  }

  static void logSuccess(dynamic msg, {String? where}) {
    where = where == null ? "" : "> $where";
    developer.log('\x1B[32m $where ___ $msg \x1B[0m');
  }

  static void logWarning(String msg, {String? where}) {
    where = where == null ? "" : "> $where";
    developer.log('\x1B[33m $where ___ $msg \x1B[0m');
  }

  static void logError(String msg, {String? where}) {
    where = where == null ? "" : "> $where";
    developer.log('\x1B[31m $where ___ $msg \x1B[0m');
  }
}
