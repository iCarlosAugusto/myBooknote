import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/pages/authentication/authentication_controller.dart';
import 'package:mybooknote/widgets/button_widget.dart';
import 'package:mybooknote/widgets/textfieldWidget.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = AuthenticationController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Olá, \n seja bem-vindo :)'),
                TextfieldWidget(
                    labelText: 'Email',
                    hintText: 'Ex: carlos@gmail.com',
                    controller: controller.emailTextfieldController,
                    validator: (value) => controller.validateEmail(value)),
                TextfieldWidget(
                  labelText: 'Senha',
                  margin: const EdgeInsets.only(top: 16),
                  controller: controller.passwordTextfieldController,
                  validator: (value) => controller.validatePassword(value),
                ),
                Observer(
                    builder: (_) => ButtonWidget(
                          onPressed: controller.authenticate,
                          title: 'Entrar',
                          isLoading: controller.isLoading,
                        )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Ou'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      color: Colors.red,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      color: Colors.orange,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 52),
                    child: Text.rich(
                      TextSpan(text: 'Não tem uma conta? ', children: [
                        TextSpan(
                            text: 'Crie agora!',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushNamed('/createAccount');
                              },
                            style: const TextStyle(color: Colors.blue))
                      ]),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
