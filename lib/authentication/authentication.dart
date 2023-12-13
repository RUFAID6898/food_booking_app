import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/home/homepage.dart';
import 'package:food_app/loging_page/login_page.dart';
import 'package:food_app/services/auth_services.dart';

// ignore: must_be_immutable
class Authentication extends StatelessWidget {
  Authentication({super.key});

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return LogingPage();
        }
      },
    ));
  }
}
