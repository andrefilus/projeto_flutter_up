class LoginResponse {
  final String status;
  final String msg;

  LoginResponse.fromJson(Map<String,dynamic> map) :
        status = map["status"],
        msg = map["msg"];
}