import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:otobus_app/model/login_model.dart';
import 'package:otobus_app/model/register_request_model.dart';
import 'package:otobus_app/model/register_response_model.dart';
import 'package:otobus_app/service/api/_service_base.dart';

// URL =>  http://192.168.1.35:8000/api/auth/...

class AuthService extends ServiceBase {
  final Dio dio = Dio();
  final String auth = "auth/";

  Future<RegisterResponseModel> register(RegisterRequestModel register) async {
    String url = baseUrl + auth + "register";

    Map<String, dynamic> data = {
      "name": register.name,
      "surname": register.surname,
      "email": register.email,
      "password": register.password,
      "gender": register.gender,
    };

    try {
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        var model = RegisterResponseModel.fromJSON(response.data);
        return model;
      }
    } on DioException catch (error) {
      debugPrint("ERROR: DioException");

      if (error.response == null) {
        debugPrint("ERROR: DioException -> error.response is null.");
        return RegisterResponseModel(success: false, message: "Sunucu hatası.");
      }

      if (error.response!.statusCode == 400) {
        debugPrint("ERROR: DioException.statusCode=400");
        /***************************************************************
            error.response.data 
            -------------------
            { 
                data : {
                    "success" : false,
                    "message" : "Bu email adresi kullanılmaktadır."
                }
            }
        ***************************************************************/
        var model = RegisterResponseModel.fromJSON(error.response!.data);
        return model;
      }
    } catch (error) {
      debugPrint("HATA_register_'auth_service.dart'_ : ${error.toString()}");
    }

    return RegisterResponseModel(success: false, message: "Bilinmeyen hata.");
  }

  Future<LoginResponseModel> login(
      {required String email, required String password}) async {
    String url = baseUrl + auth + "login";
    Map<String, String> data = {"email": email, "password": password};

    try {
      Response response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        var model = LoginResponseModel.fromJSON(response.data);
        print(model.token);
        return model;
      }
    } on DioException catch (error) {
      debugPrint("ERROR: DioException");

      if (error.response == null) {
        debugPrint("ERROR: DioException -> error.response is null.");
        return LoginResponseModel(false, null, null, "Sunucu hatası.");         
      }

      if (error.response!.statusCode == 401) {
        debugPrint("ERROR: DioException.statusCode=401");
        /*******************************************************************
            {
                data : { 
                    "data":null,
                    "success":false,
                    "message":"Email ile eşleşen bir kullanıcı bulunamadı."
                }
            }
        ********************************************************************/

        String message = error.response!.data["message"] ?? "";

        var model = 
            LoginResponseModel(false, null, null, message);
        return model;
      }
    } catch (e) {
      debugPrint("HATA_login_'auth_service.dart'_ : ${e.toString()}");
    }

    return LoginResponseModel(false, null, null, "Bilinmeyen hata.");
  }
}
