import 'package:applozic_example/config.dart';
import 'package:applozic_example/home/home.dart';
import 'package:applozic_flutter/applozic_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideSignUpButton: true,
      hideForgotPasswordButton: true,
      onSubmitAnimationCompleted: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const HomePage()));
      },
      onSignup: (LoginData loginData) {},
      onLogin: (LoginData loginData) async {
        final Map<String, dynamic> user = {
          'applicationId': appID, //Mandatory
          'userId': loginData.name, //Mandatory
          'displayName': loginData.name,
          'password': loginData.password,
          'authenticationTypeId': 1 //Mandatory
        };
        final result = await ApplozicFlutter.login(user);
        print(result);
      },
      onRecoverPassword: (String email) {},
    );
  }
}
