class SignUpResponse {
  final bool? success;
  final String? message;
  final String? token;
  final String? tokenExpiration;
  final User? user;

  SignUpResponse({
    this.success,
    this.message,
    this.token,
    this.tokenExpiration,
    this.user,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SignUpResponse();

    return SignUpResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      tokenExpiration: json['tokenExpiration'] as String?,
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      'tokenExpiration': tokenExpiration,
      'user': user?.toJson(),
    };
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? createAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      createAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id ?? "not Found Id",
    'name': name ?? "not Found name",
    'email': email ?? "not Found email",
    'createdAt': createAt ?? "not Found createdAt",
  };
}


class SignInModelRequest {
  final String email;
  final String password;

  SignInModelRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}