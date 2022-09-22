import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_assignment/modules/Home/home_screen.dart';
import 'package:internship_assignment/modules/Home/view_post.dart';

import 'constants/color_scheme.dart';
import 'firebase_options.dart';
import 'modules/Auth/signInScreen/login_screen.dart';
import 'modules/Auth/signUpScreen/register_screen.dart';
import 'modules/welcomeScreen/welcome_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      // name: "internship-assignment",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e);
    rethrow;
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kYellow,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
