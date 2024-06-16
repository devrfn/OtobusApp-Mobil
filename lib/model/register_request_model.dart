class RegisterRequestModel {
  String name;
  String surname;
  String email;
  String password;
  bool gender;
  RegisterRequestModel(
      {required this.name,
      required this.surname,
      required this.email,
      required this.password,
      required this.gender});
}
