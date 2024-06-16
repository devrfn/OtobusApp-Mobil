class RegisterResponseModel {
  bool success;
  String message;
  RegisterResponseModel({required this.success, required this.message});

  RegisterResponseModel.fromJSON(Map<String, dynamic> response)
      : success = response["success"] ?? "",
        message = response["message"] ?? "";
}


/*
  Response: {"success":true,"message":"Kayıt başarıyla gerçekleşti"}
*/