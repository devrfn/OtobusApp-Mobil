import 'package:otobus_app/model/sefer/sefer_extra_model.dart';

class SeferResponseExtraModel {
  List<SeferExtraModel>? data;
  bool? success;
  String? message;

  SeferResponseExtraModel({this.data, this.success, this.message});

  SeferResponseExtraModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SeferExtraModel>[];
      json['data'].forEach((v) {
        data!.add(new SeferExtraModel.fromJson(v));
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
