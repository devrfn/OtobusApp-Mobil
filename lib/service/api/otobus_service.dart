import 'package:dio/dio.dart';
import 'package:otobus_app/service/api/_service_base.dart';

class OtobusService extends ServiceBase {
  final Dio dio = Dio();
  final String otobus = "otobus/";
}
