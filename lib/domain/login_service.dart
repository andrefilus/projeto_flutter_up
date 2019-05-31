import 'dart:convert';

import 'package:aula2/domain/service/login_response.dart';
import 'package:aula2/domain/service/response.dart';
import 'package:aula2/domain/usuario.dart';
import 'package:http/http.dart' as http;

class LoginService {

  static Future<Response<Usuario>> login(String login, String senha) async {
    String url = "http://livrowebservices.com.br/rest/login";

    final body = {
      "login": login,
      "senha": senha
    };

    print("> $body");

    final httpResponse = await http.post(url, body: body);

    String s = httpResponse.body;

    final map = json.decode(s);

    print("*** MAP ***");
    print(s);

    String status = map["status"];
    String msg = map["msg"];

    final loginResponse = LoginResponse.fromJson(map);

    bool ok = "OK" == loginResponse.status;
    Usuario user;

    if(ok) {
      user = Usuario("Ricardo R Lecheta", "rlecheta@livetouch.com.br");
      user.savePrefs();
    }

    return Response.ok(user);
  }
}