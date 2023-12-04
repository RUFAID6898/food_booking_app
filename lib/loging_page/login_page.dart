// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:food_app/home/screen_home.dart';
import 'package:food_app/loging_page/phone_number_verification.dart';

import 'package:food_app/services/auth_services.dart';

class LogingPage extends StatelessWidget {
  LogingPage({super.key});

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/image/otp.jpg')),
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                authService.signInWithGoogle();
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(
                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text('Sign-in with Google')
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberVerification(),
                    ));
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  children: [
                    CircleAvatar(child: Icon(Icons.call)),
                    SizedBox(
                      width: 40,
                    ),
                    Text('Sign-in with phone')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
