class LoginResponse {
  late final String message;
  late final String username;
  late final String displayName;
  late final String email;
  late final String team;
  late final String language;
  late final String token;

  LoginResponse(
      {required this.message,
      required this.username,
      required this.displayName,
      required this.email,
      required this.team,
      required this.language,
      required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        username: json["username"],
        displayName: json["display_name"],
        email: json["email"],
        team: json["team"],
        language: json["language"],
        token: json["token"],
      );
}
