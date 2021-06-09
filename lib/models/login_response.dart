class UserInfoResponse {
  String message = "";
  String username = "";
  String displayName = "";
  String email = "";
  String team = "";
  String language = "";

  UserInfoResponse({
      required this.message,
      required this.username,
      required this.displayName,
      required this.email,
      required this.team,
      required this.language});

  UserInfoResponse.create(String message, String username, String displayName, String email, String team, String language){
        this.message = message;
        this.displayName = displayName;
        this.email = email;
        this.language = language;
        this.team = team;
        this.username = username;
      }

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>  UserInfoResponse(
        message: json["message"],
        username: json["username"],
        displayName: json["display_name"],
        email: json["email"],
        team: json["team"],
        language: json["language"],
      );


  // factory UserInfoResponse.fromJson(Map<String, dynamic> json){

  //   return UserInfoResponse(
  //         message: json["message"],
  //         username: json["username"],
  //         displayName: json["display_name"],
  //         email: json["email"],
  //         team: json["team"],
  //         language: json["language"],
  //       );
  // }

}


class LoginResponse extends UserInfoResponse {

  String token = "";

  LoginResponse({message,username, displayName, email, team, language, token}):
    super.create(message, username, displayName, email, team, language){
      this.token = token;
    }
    
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
