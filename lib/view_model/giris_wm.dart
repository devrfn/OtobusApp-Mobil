import 'package:flutter/material.dart';
import 'package:otobus_app/model/login_model.dart';
import 'package:otobus_app/service/api/auth_service.dart';
import 'package:otobus_app/service/quick_alert/quick_alert_service.dart';
import 'package:otobus_app/tools/route/routing_tool.dart';
import 'package:otobus_app/tools/validation/email_format_validation.dart';
import 'package:otobus_app/tools/validation/empty_validation.dart';
import 'package:otobus_app/tools/validation/max_length_validation.dart';
import 'package:otobus_app/tools/validation/min_length_validation.dart';
import 'package:otobus_app/tools/validation/validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GirisVM with ChangeNotifier {
  // APPBAR TITLE TEXT
  final String appBarTitleText = "Giriş Sayfası";

  // FORM KEYS
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TEXT-FIELD CONTROLLER
  final TextEditingController tfEmailController = TextEditingController();
  final TextEditingController tfPasswordController = TextEditingController();

  // FORM TEXT
  final String girisFormBaslik = "Giriş";
  final String emailTextFormFieldLabelText = "Email";
  final String sifreTextFormFieldLabelText = "Şifre";

  // GİRİŞ YAP BUTTON TEXT
  final String girisYapButtonText = "GİRİŞ";

  // KAYIT OL BUTTON TEXT
  final String kayitOlButtonText = "KAYIT OL";

  // HATA MESAJI
  String _girisFormAltBaslik = "Email ve şifrenizi giriniz.";

  // GİRİŞ BAŞARISIZ KONTROLÜ
  bool _isLoginFailed = false;
  bool get isLoginFailed => _isLoginFailed;
  set isLoginFailed(bool value) {
    _isLoginFailed = value;
    notifyListeners();
  }

  String get girisFormAltBaslik => _girisFormAltBaslik;
  set girisFormAltBaslik(String value) {
    _girisFormAltBaslik = value;
    notifyListeners();
  }

  void kayitOlSayfasiniAc(BuildContext context) {
    RoutingTool.kayitOlSayfasiniAcWithPushReplacement(context);
  }

  // FORM CONTROL VE LOGIN
  bool formControl() {
    var currentFormState = formKey.currentState;
    if (currentFormState != null) {
      bool formControl = currentFormState.validate();
      return formControl;
    }
    return false;
  }

  // LOGİN METHOD
  Future<bool> login() async {
    AuthService authService = AuthService();
    LoginResponseModel model = await authService.login(
        email: tfEmailController.text, password: tfPasswordController.text);

    

    // SUCCESS NULL
    if (model.success == null) {
      isLoginFailed = true;
      girisFormAltBaslik = _setMessageFormAltBaslik(model.message);
      return false;
    }

    // SUCCESS FALSE
    if (model.success == false) {
      isLoginFailed = true;
      girisFormAltBaslik = _setMessageFormAltBaslik(model.message);
      return false;
    }

    // TOKEN NULL KONTROLÜ
    if (model.token == null) {
      debugPrint("ERROR: Token is null.");
      girisFormAltBaslik = "Token is null.";
      isLoginFailed = true;
      return false;
    }

    // TOKEN BOŞ OLMA KONTROLÜ
    if (model.token!.isEmpty) {
      debugPrint("ERROR: Token is empty.");
      girisFormAltBaslik = "Token is empty.";
      isLoginFailed = true;
      return false;
    }

    // GİRİŞ BAŞARILI İSE
    if (model.success!) {
      // TOKEN KAYDET.
      bool result = await _saveSharedPreferences(model.token!);

      // TOKEN KAYDETME BAŞARILI İSE
      if (result) {
        isLoginFailed = false;
        resetFormBaslik();
        return true;
      }
      // TOKEN KAYDETMA BAŞARISIZ İSE.
      else {
        debugPrint(
            "ERROR: Token, shared_preferences'a kayıt edilirken hata oluştu.");
        isLoginFailed = true;
        girisFormAltBaslik = "Token hafızaya kayıt edilemedi.";
        return false;
      }
    }

    return false;
  }

  // ERROR ALERT
  Future errorAlert(BuildContext context) async {
    await QuickAlertService.errorAlert(context,
        text: girisFormAltBaslik, title: "HATA");
  }

  // SUCCESS ALERT
  Future successAlert(BuildContext context) async {
    await QuickAlertService.successAlert(context,
        text: "Giriş işlemi başarılı. Anasayfaya yönlendiriliyorsunuz.",
        title: "BAŞARILI");
  }

  // TELEFONA KAYDETME
  Future<bool> _saveSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool setResult = await prefs.setString("token", token);
    return setResult;
  }

  String _setMessageFormAltBaslik(String? message) => message ?? "HATA";

  Future anasayfaGec(BuildContext context) async {
    await successAlert(context);
    if (context.mounted) {
      RoutingTool.anasayfaGecWithPushReplacement(context);
    }
  }

  void resetFormBaslik() {
    String girisFormAltDefaultBaslik = "Email ve şifrenizi giriniz.";
    isLoginFailed = false;
    girisFormAltBaslik = girisFormAltDefaultBaslik;
  }

  String? emailValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Email boş bırakılamaz"),
      EmailFormatValidation(
          errorMessage: "Email geçerli bir formatta olmalıdır."),
      MinLengthValidation(
          minLength: 6, errorMessage: "Email 6 karakterden küçük olamaz."),
    ]);
  }

  String? sifreValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Şifre boş bırakılamaz"),
      MinLengthValidation(
          errorMessage: "Şifre 6 karakterden küçük olamaz", minLength: 6),
      MaxLengthValidation(
          maxLength: 16, errorMessage: "Şifre 16 karakterden büyük olamaz"),
    ]);
  }
}
