class LoginResponseModel {
  String? token;
  bool? success;
  DateTime? expiration;
  String? message;

  LoginResponseModel(this.success, this.token, this.expiration, this.message);

  LoginResponseModel.fromJSON(Map<String, dynamic> response) {
    token = response["data"]?["token"] ?? "";
    expiration = ((response["data"]?["expiration"] ?? "") as String).isEmpty
        ? DateTime.now()
        : DateTime.parse((response["data"]?["expiration"]));
    success = response["success"] ?? false;
    message = response["message"] ?? "";
  }
}



/*******************************************************************************

  LOGIN JSON
  ----------

      {
          "data": 
              {
                  "token": "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoiYWRtaW4xMjMiLCJTdXJuYW1lIjoiYWRtaW4xMjMiLCJDaW5zaXlldCI6IlRydWUiLCJFbWFpbCI6ImFkbWluMTIzQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwibmJmIjoxNzE1MjEzODM3LCJleHAiOjE3MTUyMTU2MzcsImlzcyI6Ind3dy5teWFwaS5jb20iLCJhdWQiOiJ3d3cubXlhcGkuY29tIn0.BgOh9PlEeHKWr3MCbJnXX2fo6BF-wtgzgm65yaZWtjQ",
                  
                  "expiration": "2024-05-09T03:47:17.06696+03:00"
              }, 
          "success": "true", 
          "message": "null"
      }
      
*******************************************************************************/