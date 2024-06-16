import 'package:flutter/material.dart';
import 'package:otobus_app/model/sefer/sefer_request_model.dart';
import 'package:otobus_app/tools/constants/cities.dart';
import 'package:otobus_app/tools/datetime/datetime_tool.dart';
import 'package:otobus_app/tools/route/routing_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otobus_app/tools/log/developer_log.dart';

class AnasayfaVM with ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ANASAYFA - APPBAR TITLE
  final String appBarTitle = "Anasayfa";

  // ANASAYDA - DRAWER HEADER
  final String drawerHeaderText = "OTOBUS APP";

  // ANASAYFA - DRAWER MENU ITEM TEXT
  final String drawerMenuItemSeferlerText = "SEFERLER";
  final String drawerMenuItemAnasayfaText = "ANASAYFA";
  final String drawerMenuItemProfilText = "PROFİL";
  final String drawerMenuItemPanelText = "PANEL";
  final String drawerMenuItemKayitOlText = "KAYIT OL";
  final String drawerMenuItemGirisText = "GİRİŞ";
  final String drawerMenuItemCikisText = "ÇIKIŞ";

  String sehirNereden = "";
  String sehirNereye = "";
  String _date = "";
  String _rawDate = "";

  // GETTER & SETTER
  String get date => _date;
  set date(String value) {
    _rawDate = value;
    String formattedDate =
        DateTimeTool.rawDateStringToFormattedDateString(value);
    _date = formattedDate;
    notifyListeners();
  }

  // CONSTRUCTOR
  AnasayfaVM() {
    _date = DateTimeTool.getFormattedDateTimeNow();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    _rawDate = DateTime(year, month, day).toString();
    sehirNereden = Cities.sehirler[0];
    sehirNereye = Cities.sehirler[1];
  }

  // DRAWER MENU KAPAT
  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  // MENÜDEN SEFERLER SAYFASINA GEÇ
  void seferlerSayfasiniAc(BuildContext context) {
    closeDrawer(context);
    RoutingTool.seferlerSayfasiniAc(context);
  }

  // SEFERLER SAYFASINI FİLTRE İLE AÇ
  void seferlerSayfasiniFiltreliAc(BuildContext context) {
    devLog.logInfo("SEFERLER SAYFASI FİLTRELİ AÇ", where: "anasayfa_wm.dart");

    SeferRequestModel arananSefer =
        SeferRequestModel(sehirNereden, sehirNereye, _rawDate);

    devLog.logInfo(arananSefer.nereden, where: "anasayfa_wm.dart");
    devLog.logInfo(arananSefer.nereye, where: "anasayfa_wm.dart");
    devLog.logInfo(arananSefer.tarih, where: "anasayfa_wm.dart");

    // RoutingTool.seferlerSayfasiniAc(context, arananSefer: arananSefer);
  }

  // PROFİL SAYFASINI AÇ
  void profilSayfasiniAc(BuildContext context) {
    closeDrawer(context);
    RoutingTool.profilSayfasiniAc(context);
  }

  // KAYIT OL SAYFASINI AÇ
  void kayitOlSayfasiniAc(BuildContext context) {
    closeDrawer(context);
    RoutingTool.kayitOlSayfasiniAcWithPush(context);
  }

  // GİRİŞ SAYFASINI AÇ
  void girisSayfasiniAc(BuildContext context) {
    closeDrawer(context);
    RoutingTool.girisSayfasiniAc(context);
  }

  // PANEL SAYFASINI AÇ
  void panelSayfasiniAc(BuildContext context) {}

  // TOKEN SİL
  Future removeTokenWithSharedPrefences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }
}
