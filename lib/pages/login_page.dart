import 'package:aula2/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:aula2/domain/login_service.dart';
import 'package:aula2/domain/service/response.dart';
import 'package:aula2/pages/home_page.dart';
import 'package:aula2/utils/alert.dart';
import 'package:aula2/utils/nav.dart';
import 'package:aula2/widgets/blue_button.dart';
import 'package:aula2/widgets/progress.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var showProgress = false;

  final _tLogin = TextEditingController(text: "lecheta@up.com.br");
  final _tSenha = TextEditingController(text: "lecheta");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
////        title: Text("Carros", textAlign: TextAlign.center),
//        actions: <Widget>[
////          IconButton(
//////            icon: Icon(
//////              Icons.refresh,
//////            ),
////            onPressed: () {
////              setState(() {
////                showProgress = false;
////              });
////            },
////          )
//        ],
//      ),
      body: _body(context),
      backgroundColor: Colors.yellow,
    );
  }

  _body(context) {
    return Container(
//      margin: EdgeInsets.all(20),
    padding: EdgeInsets.all(20),
      color: Colors.grey[900],
      child: ListView(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Center(
//            child: Image.asset(
//              "assets/imgs/positivo.jpg",
//              height: 100,
//            ),
//          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Email",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          TextField(
            controller: _tLogin,
            style: TextStyle(fontSize: 20, color: Colors.greenAccent[400]),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Senha",
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          TextField(
            controller: _tSenha,
            style: TextStyle(fontSize: 20, color: Colors.greenAccent[400]),
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: showProgress
                ? Progress()
                : BlueButton(
              "LOGIN",
                  () => _onClickLogin(context),
            ),
          )
        ],
      ),
    );
  }

  _onClickLogin(context) async {
    final login = _tLogin.text;
    final senha = _tSenha.text;
//
//    if(!_formKey.currentState.validate()){
//      return;
//    }

    print("Login: $login, senha: $senha");

    setState(() {
      showProgress = true;
    });

    final service = FirebaseService();
    final response = await service.login(login, senha);

    if(response.isOk()) {
      pushReplacement(context, HomePage());
    } else {
      alert(context,msg: response.msg);
    }

    setState(() {
      showProgress = false;
    });
  }

//  _onClickLogin(context) async {
//    print("Login!");
//
//    setState(() {
//      showProgress = true;
//    });
//
//    String login = _tLogin.text;
//    String senha = _tSenha.text;
//
//    Response response = await LoginService.login(login,senha);
//
//    if(response.isOk()) {
//      push(context, HomePage());
//    } else {
//      alert(context,msg: response.msg);
//    }
//
//    setState(() {
//      showProgress = false;
//    });
//  }
}

