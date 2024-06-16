import 'package:flutter/material.dart';
import 'package:otobus_app/service/quick_alert/quick_alert_service.dart';
import 'package:otobus_app/tools/route/routing_tool.dart';
import 'package:otobus_app/tools/validation/card_date_format_validation.dart';
import 'package:otobus_app/tools/validation/card_date_validation.dart';
import 'package:otobus_app/tools/validation/empty_validation.dart';
import 'package:otobus_app/tools/validation/max_length_validation.dart';
import 'package:otobus_app/tools/validation/min_length_validation.dart';
import 'package:otobus_app/tools/validation/validator.dart';

class BiletSatinAlVM with ChangeNotifier {
  // APPBAR TITLE TEXT
  final String appBarTitleText = "Bilet Satın Alma";

  // FORM KEYS
  final GlobalKey<FormState> odemeBilgileriFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> yolcuBilgileriFormKey = GlobalKey<FormState>();

  // TEXT-FIELD CONTROLLER
  final TextEditingController isimController = TextEditingController();
  final TextEditingController soyisimController = TextEditingController();
  final TextEditingController cinsiyetController = TextEditingController();
  final TextEditingController kartNumarasiController = TextEditingController();
  final TextEditingController tarihController = TextEditingController();
  final TextEditingController csvController = TextEditingController();

  // YOLCU BİLGİLER FORM TEXT
  final String yolcuBilgileriText = "YOLCU BİLGİLERİ";
  final String isimTextFormFieldLabelText = "İsim";
  final String soyisimTextFormFieldLabelText = "Soyisim";

  // ÖDEME YAP BUTTON TEXT
  final String odemeYapButtonText = "ÖDEME YAP";

  // ÖDEME BİLGİLER FORM TEXT
  final String odemeBilgileriText = "ÖDEME BİLGİLERİ";
  final String kartNumarasiText = "Kart Numarası";
  final String kartTarihTextFormFieldLabelText = "Tarih (AA/YY)";
  final String kartCSVTextFormFieldLabelText = "CSV";

  // SEYEHAT BİLGİLERİ CARD TEXT
  final String seyehatBilgileri = "SEYEHAT BİLGİLERİ";
  final String seyehatBilgileriFiyatText = "Fiyat";
  final String seyehatBilgileriTarihVeSaatText = "Tarih & Saat";
  final String seyehatBilgileriVarisText = "Varış";
  final String seyehatBilgileriKalkisText = "Kalkış";

  String? kartCSVValidator(String? input) {
    return Validator.run(
      input,
      [
        EmptyValidation(errorMessage: "CSV boş bırakılamaz."),
        MinLengthValidation(
            minLength: 3, errorMessage: "CSV 3 karakterden az olamaz."),
        MaxLengthValidation(
            maxLength: 3, errorMessage: "CSV 3 karakterden fazla olamaz.")
      ],
    );
  }

  String? soyisimValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Soyisim boş bırakılamaz."),
      MinLengthValidation(
          minLength: 2, errorMessage: "Soyisim 2 karakterden az olamaz."),
      MaxLengthValidation(
          maxLength: 16, errorMessage: "Soyisim 16 karakterden fazla olamaz.")
    ]);
  }

  String? isimValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "İsim boş bırakılamaz."),
      MinLengthValidation(
          minLength: 2, errorMessage: "İsim 2 karakterden az olamaz."),
      MaxLengthValidation(
          maxLength: 16, errorMessage: "İsim 16 karakterden fazla olamaz.")
    ]);
  }

  String? kartTarihiValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(
          errorMessage: "Kart son kullanma tarihi boş bırakılamaz."),
      MinLengthValidation(
          minLength: 5,
          errorMessage: "Kart son kullanma tarihi 4 karakterden az olamaz."),
      MaxLengthValidation(
          maxLength: 5,
          errorMessage: "Kart son kullanma tarihi 4 karakterden fazla olamaz."),
      CardDateValidation(errorMessage: "Kartın son kullanım tarihi geçmiştir."),
      CardDateFormatValidation(
          errorMessage: "Kartın son kullanım tarihi formatı yanlıştır."),
    ]);
  }

  String? kartNumarasiValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Kart numarası boş bırakılamaz."),
      MinLengthValidation(
          minLength: 19,
          errorMessage: "Kart numarası 16 karakterden az olamaz."),
      MaxLengthValidation(
          maxLength: 19,
          errorMessage: "Kart numarası 16 karakterden fazla olamaz.")
    ]);
  }

  void kartTarihFormat(String value) {
    // Max girdi kontrolü sağlar.
    // 12-245 -> 12-24
    if (value.length >= 6) {
      tarihController.text = value.substring(0, 5);
      return;
    }

    if (value.length == 3) {
      // 123 -> 12/3
      if (value[value.length - 1] == "/") {
        String str = value.substring(0, value.length - 1);
        tarihController.text = str;
      }
      // 12/ -> 12
      else {
        int length = value.length;
        String str = tarihController.text;
        String lastCharacter = str[value.length - 1];
        String mainString = str.substring(0, length - 1);
        mainString = mainString + "/" + lastCharacter;
        tarihController.text = mainString;
      }
      return;
    }
  }

  void kartNumarasiFormat(String value) {
    // Kart numarası uzunluk kontrol
    if (value.length >= 20) {
      kartNumarasiController.text = value.substring(0, 19);
    }

    if (value.length == 5 || value.length == 10 || value.length == 15) {
      // 1234-1234-1234-  ->  1234-1234-1234
      // 1234-1234-       ->  1234-1234
      // 1234-            ->  1234
      if (value[value.length - 1] == "-") {
        String str = value.substring(0, value.length - 1);
        kartNumarasiController.text = str;
      }
      // 12341            ->  1234-1
      // 1234-12341       ->  1234-1234-1
      // 1234-1234-12341  ->  1234-1234-1234-1
      else {
        int length = value.length;
        String str = kartNumarasiController.text;
        String lastCharacter = str[value.length - 1];
        String mainString = str.substring(0, length - 1);
        mainString = mainString + "-" + lastCharacter;
        kartNumarasiController.text = mainString;
      }
      return;
    }
  }

  Future odemeYap(BuildContext context) async {
    // ÖDEME BİLGİLERİ VALID
    if (odemeBilgileriFormKey.currentState != null &&
        yolcuBilgileriFormKey.currentState != null) {
      bool isOdemeBilgileriValid =
          odemeBilgileriFormKey.currentState!.validate();
      bool isYolcuBilgileriValid =
          yolcuBilgileriFormKey.currentState!.validate();
      if (isOdemeBilgileriValid && isYolcuBilgileriValid) {
        // [ ] ÖDEME GERÇEKLEŞTİRİLİR
        await showSuccessAlert(context);
        RoutingTool.anasayfaGecWithPushReplacement(context);
      }
    }
  }

  Future showSuccessAlert(BuildContext context) async {
    String title = "BAŞARILI";
    String text =
        "Ödeme işleminiz başarıyla gerçekleşti. Anasayfaya geçebilirsiniz.";
    await QuickAlertService.successAlert(context, text: text, title: title);
  }
}
