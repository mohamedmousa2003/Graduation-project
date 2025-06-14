class RequestSignUpModel {
  final String name;
  final String email;
  final String password;
  final String rePassword;

  RequestSignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
  });

  Map<dynamic, String> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'rePassword': rePassword,
    };
  }
}