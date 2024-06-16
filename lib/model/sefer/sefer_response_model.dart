import 'package:otobus_app/model/sefer/sefer_model.dart';

class SeferResponseModel {
  List<SeferModel>? data;
  bool? success;
  String? message;

  SeferResponseModel({this.data, this.success, this.message});

  SeferResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SeferModel>[];
      json['data'].forEach((v) {
        data!.add(SeferModel.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}



