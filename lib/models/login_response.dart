class LoginResponse{
  final String message;
  final String username;
  final String displayName;
  final String email;
  final String team;
  final String language;
  final String token;

  LoginResponse({this.message, this.username, this.displayName,
  this.email, this.team, this.language, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message:json["message"], 
    username: json["username"],
    displayName: json["display_name"],
    email: json["email"],
    team: json["team"],
    language: json["language"],
    token: json["token"],
    );
  
}