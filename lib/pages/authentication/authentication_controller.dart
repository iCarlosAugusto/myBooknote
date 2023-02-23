import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:mybooknote/routes/global_context.dart';
import 'package:go_router/go_router.dart';
part 'authentication_controller.g.dart';

class AuthenticationController = _AuthenticationControllerBase with _$AuthenticationController;

abstract class _AuthenticationControllerBase with Store {
  TextEditingController emailTextfieldController = TextEditingController();
  TextEditingController passwordTextfieldController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  checkUser() {
    Box userStorage = Hive.box('userStorage');
    var user = userStorage.get('user');
    print(user);
  }

  @action
  Future<void> authenticate() async {

    if(!formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextfieldController.text, 
        password: passwordTextfieldController.text
      );
      GlobalContext.navigatorKey.currentContext!.goNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(GlobalContext.navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Email ou senha incorretos'), backgroundColor: Colors.red),
      );
    }
  }

  @action
  validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigátório';
    }

    if (!value.contains('@')) {
      return 'Email inválido';
    }

    return null;
  }

  @action
  validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigátório';
    }
    return null;
  }
}
