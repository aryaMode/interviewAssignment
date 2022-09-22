import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color_scheme.dart';
import '../../widgets/rounded_button.dart';
import '../Auth/signInScreen/login_screen.dart';
import '../Auth/signUpScreen/register_screen.dart';
import 'background.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "welcome_screen";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/images/auth/components/welcome screen boy.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "LOGIN",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kLightPurple,
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
