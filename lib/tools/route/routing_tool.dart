import 'package:flutter/material.dart';
import 'package:otobus_app/model/sefer/sefer_request_model.dart';
import 'package:otobus_app/view/anasayfa_view.dart';
import 'package:otobus_app/view/bilet_satin_alma_view.dart';
import 'package:otobus_app/view/seferler_view.dart';
import 'package:otobus_app/view/giris_view.dart';
import 'package:otobus_app/view/kayitol_view.dart';
import 'package:otobus_app/view/profil_view.dart';
import 'package:otobus_app/view_model/anasayfa_vm.dart';
import 'package:otobus_app/view_model/bilet_satin_alma_vm.dart';
import 'package:otobus_app/view_model/seferler_wm.dart';
import 'package:otobus_app/view_model/giris_wm.dart';
import 'package:otobus_app/view_model/kayitol_wm.dart';
import 'package:otobus_app/view_model/profil_vm.dart';
import 'package:provider/provider.dart';

class RoutingTool {

  static void anasayfaGecWithPush(BuildContext context) {
        MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ProfilVM())],
        child: ProfilView(),
      );
    });

    Navigator.push(context, pageRoute);
  }

  static void anasayfaGecWithPushReplacement(BuildContext context) {
        MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => AnasayfaVM())],
        child: AnasayfaView(),
      );
    });

    Navigator.push(context, pageRoute);
  }


  static void seferlerSayfasiniAc(BuildContext context,
      {SeferRequestModel? arananSefer}) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SeferlerVM(arananSefer: arananSefer))
        ],
        child: SeferlerView(),
      );
    });

    Navigator.push(context, pageRoute);
  }

  static void profilSayfasiniAc(BuildContext context) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => ProfilVM())],
        child: ProfilView(),
      );
    });

    Navigator.push(context, pageRoute);
  }

  static void girisSayfasiniAc(BuildContext context) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => GirisVM())],
        child: GirisView(),
      );
    });

    Navigator.push(context, pageRoute);
  }

  static void kayitOlSayfasiniAcWithPush(BuildContext context) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => KayitOlWM())],
        child: KayitOlView(),
      );
    });

    Navigator.push(context, pageRoute);
  }

  static void kayitOlSayfasiniAcWithPushReplacement(BuildContext context) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => KayitOlWM())],
        child: KayitOlView(),
      );
    });

    Navigator.pushReplacement(context, pageRoute);
  }

  static void biletSatinAlSayfasiniAcWithPush(BuildContext context) {
    MaterialPageRoute pageRoute =
        MaterialPageRoute(builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BiletSatinAlVM())
        ],
        child: BiletSatinAlView(),
      );
    });
    Navigator.push(context, pageRoute);
  }
}
