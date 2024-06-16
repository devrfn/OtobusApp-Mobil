import 'package:flutter/material.dart';
import 'package:otobus_app/model/sefer/sefer_extra_model.dart';
import 'package:otobus_app/model/sefer/sefer_request_model.dart';
import 'package:otobus_app/service/api/sefer_service.dart';
import 'package:otobus_app/tools/constants/cities.dart';
import 'package:otobus_app/tools/datetime/datetime_tool.dart';
import 'package:otobus_app/tools/route/routing_tool.dart';

class SeferlerVM with ChangeNotifier {
  String sehirNereden = "";
  String sehirNereye = "";
  String _date = "";
  String _rawDate = "";
  bool isLoading = false; // Veri çektim mi?

  int _selectedKoltukNo = 0;

  int get selectedKoltukNo => _selectedKoltukNo;
  set selectedKoltukNo(int value) {
    _selectedKoltukNo = value;
    notifyListeners();
  }

  List<SeferExtraModel> _seferler = [];

  // getter & setter
  List<SeferExtraModel> get seferler => _seferler;
  set seferler(List<SeferExtraModel> value) {
    _seferler = value;
    notifyListeners();
  }

  // Date getter & setter
  String get date => _date;
  set date(String value) {
    _rawDate = value;
    String formattedDate =
        DateTimeTool.rawDateStringToFormattedDateString(value);
    _date = formattedDate;
    notifyListeners();
  }

  // Constructor
  SeferlerVM({SeferRequestModel? arananSefer}) {
    if (arananSefer != null) {
      sehirNereden = arananSefer.nereden;
      sehirNereye = arananSefer.nereye;
      date = arananSefer.tarih;
      seferleriGetirExtra();
    } else {
      sehirNereden = Cities.sehirler[0];
      sehirNereye = Cities.sehirler[1];
      _date = DateTimeTool.getFormattedDateTimeNow();
      _rawDate = DateTime.now().toString();
    }
  }

  // getall-extra
  Future seferleriGetirExtra() async {
    SeferRequestModel arananSeferModel =
        SeferRequestModel(sehirNereden, sehirNereye, _rawDate);

    SeferService seferService = SeferService();
    var model = await seferService.getAllSeferExtra(arananSeferModel);

    if (model.success == null || model.success == false) {
      // hataMesaji = model.message == null ? "HATA" : model.message!;
      return;
    }
    if (model.data == null) {
      // hataMesaji = model.message == null ? "HATA" : model.message!;
      return;
    }
    if (model.data != null) {
      // hataMesaji = "";
      seferler = model.data!;
      return;
    }
  }

  /// getall: methodunu çalıştıracak bir etkisi yok çünkü seferlerin tipi değişik.
  Future seferleriGetir() async {
    SeferService seferService = SeferService();
    var model = await seferService.getAllSefer();

    if (model.success == null || model.success == false) {
      // hataMesaji = model.message == null ? "HATA" : model.message!;
      return;
    }
    if (model.data == null) {
      // hataMesaji = model.message == null ? "HATA" : model.message!;
      return;
    }
    if (model.data != null) {
      // seferler = model.data!; => Listeyi değiştir.
      return;
    }
  }

  String getTimeFromDateTimeString(String dateString) {
    String time = DateTimeTool.getTimeFromDateTimeString(dateString);
    String hoursAndMinutes = DateTimeTool.getHourAndMinute(time);
    return hoursAndMinutes;
  }

  void biletSatinAlmaSayfasiniAc(BuildContext context) {
    RoutingTool.biletSatinAlSayfasiniAcWithPush(context);
  }
}
