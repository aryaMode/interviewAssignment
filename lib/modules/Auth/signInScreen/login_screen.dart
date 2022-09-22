import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internship_assignment/helpers/conversion.dart';
import 'package:internship_assignment/modules/Auth/providers/providers.dart';
import 'package:internship_assignment/modules/Home/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../constants/color_scheme.dart';
import '../../../constants/icons.dart';
import '../../../helpers/showSnackBar.dart';
import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_input_field.dart';
import '../../../widgets/rounded_password_field.dart';
import '../models/user.dart';
import 'background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String id = "login_screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isAuthenticated = true;
  bool obscureText = true;
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: !isAuthenticated,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SvgPicture.asset(
                    "assets/images/auth/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  hintText: "Email",
                  prefixWidget: mailIcon,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                RoundedPasswordField(
                  showPass: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  obscureText: obscureText,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                RoundedButton(
                  color: kPurple,
                  textStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  text: "LOGIN",
                  onPressed: () async {
                    if (email != '' && password != '') {
                      try {
                        await signIn(email, password);
                        setState(() {
                          isAuthenticated = false;
                        });
                        setState(() {
                          isAuthenticated = true;
                        });
                        Navigator.pushReplacementNamed(context, HomePage.id);
                      } on FirebaseAuthException catch (error) {
                        showSnackBar(context, error.toString());
                        setState(() {
                          isAuthenticated = true;
                        });
                        rethrow;
                      }
                    }
                  },
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException {
      rethrow;
    }

    ref.read(userProvider.state).state = AuthUser.fromMap(objectConversion(
        (await FirebaseDatabase.instance
                .ref("users")
                .orderByChild("uid")
                .equalTo(FirebaseAuth.instance.currentUser?.uid)
                .get())
            .children
            .first
            .value));
  }
}
