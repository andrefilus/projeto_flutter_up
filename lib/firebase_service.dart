import 'dart:async';


import 'package:aula2/domain/service/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> cadastrar(String nome, String email, String senha) async {
    try {
      // Usuario do Firebase
      final FirebaseUser fUser = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      print("Usuario criado: ${fUser.displayName}");

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;
      userUpdateInfo.photoUrl = "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png";
      fUser.updateProfile(userUpdateInfo);

      // Resposta genérica
      return Response.ok("Usuário criado com sucesso");
    } catch(error) {
      print(error);

      if(error is PlatformException) {
        print("Error Code ${error.code}");

        return Response.error("Erro ao criar um usuário.\n\n${error.message}");
      }

      return Response.error("Não foi possível criar um usuário.");
    }
  }

  Future<Response> login(String email, String senha) async {
    try {
      // Usuario do Firebase
      final FirebaseUser fUser = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      print("Usuario Logado: ${fUser.displayName}");

      // Resposta genérica
      return Response.ok("Login efetuado com sucesso");
    } catch(error) {
      print(error);

      if(error is PlatformException) {
        print("Error Code ${error.code}");

        return Response.error("Email/Senha incorretos\n\n${error.message}");
      }

      return Response.error("Não foi possível fazer o login");
    }
  }

  Future<Response> loginGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signInSilently();
    if(googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Usuario do Firebase
    final FirebaseUser fuser = await _auth.signInWithCredential(credential);
    print("signed in " + fuser.displayName);

    // Resposta genérica
    return Response.ok("Login efetuado com sucesso");
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
