import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool? _isLoginned;
  String? _isim;
  String? _soyisim;
  bool? _cinsiyet;
  String? _rol;
  String? _email;

  int? _exp; // Token son kullanma tarihi. (Saniye cinsinden 1970'den bu yana)
  int? _nbf; // Token başlangıç tarihi.

  // isLoginned getter & setter
  bool? get isLoginned => _isLoginned;
  set isLoginned(bool? value) {
    _isLoginned = value;
    notifyListeners();
  }

  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  // isim getter & setter
  String? get isim => _isim;
  set isim(String? value) {
    _isim = value;
  }

  // soyisim getter & setter
  String? get soyisim => _soyisim;
  set soyisim(String? value) {
    _soyisim = value;
  }

  // cinsiyet getter & setter
  bool? get cinsiyet => _cinsiyet;
  set cinsiyet(bool? value) {
    _cinsiyet = value;
  }

  // rol getter & setter
  String? get rol => _rol;
  set rol(String? value) {
    _rol = value;
  }

  // exp date getter & setter
  int? get exp => _exp;
  set exp(int? value) {
    _exp = value;
  }

  // nbf date getter & setter
  int? get nbf => _nbf;
  set nbf(int? value) {
    _nbf = value;
  }

  // tokenControl
  Future tokenControl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    print(token);

    isLoginned = (token != null)
        ? (token.isNotEmpty)
            ? _decodeToken(token)
            : false
        : false;
  }

  // decodeToken
  bool _decodeToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    String tokenIsim = decodedToken["Name"] ?? "";
    String tokenSoyisim = decodedToken["Surname"] ?? "";
    String tokenCinsiyet = decodedToken["Cinsiyet"] ?? "";
    String email = decodedToken["Email"] ?? "";
    String tokenRol = decodedToken[
            "http://schemas.microsoft.com/ws/2008/06/identity/claims/role"] ??
        "";
    int tokenExp = decodedToken["exp"] ?? 0;
    int tokenNbf = decodedToken["nbf"] ?? 0;

    if (tokenIsim.isNotEmpty &&
        tokenSoyisim.isNotEmpty &&
        tokenCinsiyet.isNotEmpty &&
        email.isNotEmpty &&
        tokenRol.isNotEmpty &&
        tokenExp > 0 &&
        tokenNbf > 0) {
      isim = tokenIsim;
      soyisim = tokenSoyisim;
      cinsiyet = bool.parse(tokenCinsiyet.toLowerCase());
      email = email;

      rol = tokenRol;
      print(rol);
      exp = tokenExp;
      nbf = tokenNbf;

      isLoginned = true;

      return true;
    } else {
      return false;
    }
  }

  void reset() {
    cinsiyet = null;
    isim = null;
    soyisim = null;
    exp = null;
    nbf = null;
    rol = null;
    isLoginned = false;
    email = null;
  }
}
