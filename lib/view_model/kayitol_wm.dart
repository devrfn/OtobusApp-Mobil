import 'package:flutter/material.dart';
import 'package:otobus_app/model/register_request_model.dart';
import 'package:otobus_app/model/register_response_model.dart';
import 'package:otobus_app/service/api/auth_service.dart';
import 'package:otobus_app/service/quick_alert/quick_alert_service.dart';
import 'package:otobus_app/tools/route/routing_tool.dart';
import 'package:otobus_app/tools/validation/email_format_validation.dart';
import 'package:otobus_app/tools/validation/empty_validation.dart';
import 'package:otobus_app/tools/validation/max_length_validation.dart';
import 'package:otobus_app/tools/validation/min_length_validation.dart';
import 'package:otobus_app/tools/validation/validator.dart';

class KayitOlWM extends ChangeNotifier {
  // APPBAR TITLE
  final appBarTitle = "Kayıt Ol";

  // KAYIT OL FORM - FORM KEY
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // KAYIT OL FORM - BUTTON TEXT
  final String kayitOlButtonText = "KAYIT OL";
  final String erkekRadioButtonTitleText = "Erkek";
  final String kadinRadioButtonTitleText = "Kadın";

  // KAYIT OL FORM - FORM TEXT
  String kayitOlFormBaslik = "KAYIT OL";

  // KAYIT OL FORM - ALT BAŞLIK, GETTER & SETTER
  String _kayitOlFormAltBaslik = "Hesap oluştur.";
  String get kayitOlFormAltBaslik => _kayitOlFormAltBaslik;
  set kayitOlFormAltBaslik(String value) {
    _kayitOlFormAltBaslik = value;
    notifyListeners();
  }

  // KAYIT OL FORM - TEXT FORM FIELD CONTROLLER
  final TextEditingController tfIsimController = TextEditingController();
  final TextEditingController tfSoyisimController = TextEditingController();
  final TextEditingController tfEmailController = TextEditingController();
  final TextEditingController tfPasswordController = TextEditingController();

  // KAYIT OL FORM - TEXT FORM FIELD LABEL TEXT
  final String isimTextFormFieldLabelText = "İsim";
  final String soyisimTextFormFieldLabelText = "Soyisim";
  final String emailTextFormFieldLabelText = "Email";
  final String sifreTextFormFieldLabelText = "Şifre";

  // KAYIT OL FORM - CİNSİYET RADİO BUTTON, GETTER & SETTER
  final String cinsiyetRadioButtonText = "Cinsiyet";
  String _cinsiyetRadioButtonErrorText = "";
  String get cinsiyetRadioButtonErrorText => _cinsiyetRadioButtonErrorText;
  set cinsiyetRadioButtonErrorText(String value) {
    _cinsiyetRadioButtonErrorText = value;
    notifyListeners();
  }

  // KAYIT OL FORM - CİNSİYET RADİO BUTTON GROUP VALUE, GETTER & SETTER
  int? _cinsiyetGroupValue = -1;
  int? get cinsiyetGroupValue => _cinsiyetGroupValue;
  set cinsiyetGroupValue(int? value) {
    _cinsiyetGroupValue = value;
    notifyListeners();
  }

  // KAYIT OLMA BAŞARISIZ MI -> GETTER & SETTER
  bool _isKayitOlFailed = false;
  bool get isKayitOlFailed => _isKayitOlFailed;
  set isKayitOlFailed(bool value) {
    _isKayitOlFailed = value;
    notifyListeners();
  }

  // GİRİŞ SAYFASINI AÇ
  void girisSayfasiniAc(BuildContext context) {
    Navigator.pop(context);
    RoutingTool.girisSayfasiniAc(context);
  }

  void resetFormBaslik() {
    String kayitOlFormDefaultBaslik = "Hesap oluştur.";
    isKayitOlFailed = false;
    kayitOlFormAltBaslik = kayitOlFormDefaultBaslik;
  }

  // VALIDATOR
  String? emailValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Email boş bırakılamaz"),
      EmailFormatValidation(
          errorMessage: "Email geçerli bir formatta olmalıdır."),
      MinLengthValidation(
          minLength: 6, errorMessage: "Email 6 karakterden küçük olamaz."),
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

  String? soyisimValidator(String? input) {
    return Validator.run(input, [
      EmptyValidation(errorMessage: "Soyisim boş bırakılamaz."),
      MinLengthValidation(
          minLength: 2, errorMessage: "İsim 2 karakterden az olamaz."),
      MaxLengthValidation(
          maxLength: 16, errorMessage: "İsim 16 karakterden fazla olamaz.")
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

  bool cinsiyetValidator() {
    if (_cinsiyetGroupValue == -1) {
      cinsiyetRadioButtonErrorText = "* Cinsiyet alanı boş bırakılamaz.";
      return false;
    }
    cinsiyetRadioButtonErrorText = "";
    return true;
  }

  // KAYIT OL
  Future<void> register(BuildContext context) async {
    var currentFormState = formKey.currentState;
    if (currentFormState != null) {
      bool formControl = currentFormState.validate();
      bool cinsiyetControl = cinsiyetValidator();

      // CİNSİYET VALİDASYONU BAŞARISIZ
      if (!cinsiyetControl) return;

      // FORM VALİDASYONU BAŞARILI
      if (formControl) {
        var requestModel = _createRegisterRequestModel();
        AuthService authService = AuthService();
        RegisterResponseModel model = await authService.register(requestModel);

        // KAYIT OLMA BAŞARILI
        if (model.success && context.mounted) {
          isKayitOlFailed = false;
          await _showSuccessAlert(context);
          girisSayfasiniAc(context);
        }

        // KAYIT OLMA BAŞARISIZ
        else {
          isKayitOlFailed = true;
          kayitOlFormAltBaslik = model.message;
          _showFailedAlert(context, model.message);
        }
      }

      // FORM VALİDASYONU BAŞARISIZ
      else {
        resetFormBaslik();
      }
    }
  }

  // CREATE REGISTER REQUET MOEDL
  RegisterRequestModel _createRegisterRequestModel() {
    return RegisterRequestModel(
        name: tfIsimController.text,
        surname: tfSoyisimController.text,
        email: tfEmailController.text,
        password: tfPasswordController.text,
        gender: _cinsiyetGroupValue == 1 ? true : false);
  }

  // FAILED ALERT DIALOG
  Future _showFailedAlert(BuildContext context, String text) async {
    await QuickAlertService.errorAlert(context, title: "HATA", text: text);
  }

  // SUCCESS ALERT DIALOG
  Future _showSuccessAlert(BuildContext context) async {
    String title = "BAŞARILI";
    String text =
        "Kayıt olma işlemi başarılı. Giriş sayfasına yönlendiriliyorsunuz.";

    await QuickAlertService.successAlert(context, title: title, text: text);
  }
}
