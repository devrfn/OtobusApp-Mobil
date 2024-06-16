import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:otobus_app/model/sefer/sefer_request_model.dart';
import 'package:otobus_app/model/sefer/sefer_response_extra_model.dart';
import 'package:otobus_app/model/sefer/sefer_response_model.dart';
import 'package:otobus_app/service/api/_service_base.dart';

class SeferService extends ServiceBase {
  String sefer = "sefer/";
  Dio dio = Dio();

  // GetAllExtra
  Future<SeferResponseExtraModel> getAllSeferExtra(SeferRequestModel arananSeferModel) async {
    String url = baseUrl + sefer + "getallextra";

    Map<String, String> data = {
      "nereden": arananSeferModel.nereden,
      "nereye": arananSeferModel.nereye,
      "tarih": arananSeferModel.tarih,
    };

    try {
      var response = await dio.post(url, data:data);
      Map<String, dynamic> json = jsonDecode(response.toString());
      print(json);

      if (response.statusCode == 200) {
        debugPrint("İstek başarılı.");
        SeferResponseExtraModel model = SeferResponseExtraModel.fromJson(json);
        return model;
      }
    } on DioException catch (error) {
      debugPrint("ERROR: DioException");

      if (error.response == null) {
        return SeferResponseExtraModel();
      }
      if (error.response!.statusCode == 400) {
        Map<String, dynamic> json = jsonDecode(error.response.toString());
        print(json);
      }

    } catch (e) {
      debugPrint(e.toString());
    }
    return SeferResponseExtraModel();
  }

  // GetAll
  Future<SeferResponseModel> getAllSefer() async {
    String url = baseUrl + sefer + "getall";

    try {
      var response = await dio.get(url);
      Map<String, dynamic> json = jsonDecode(response.toString());

      print(json);

      if (response.statusCode == 200) {
        SeferResponseModel model = SeferResponseModel.fromJson(json);
        return model;
      }
    } on DioException catch (error) {
      debugPrint("ERROR: DioException");

      if (error.response == null) {
        return SeferResponseModel();
      }
      if (error.response!.statusCode == 400) {
        Map<String, dynamic> json = jsonDecode(error.response.toString());
        return SeferResponseModel.fromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return SeferResponseModel();
  }
}
