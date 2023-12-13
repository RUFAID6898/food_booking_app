import 'package:flutter/material.dart';

import 'package:food_app/loging_page/phone_number_verification.dart';

import 'package:food_app/services/auth_services.dart';

// ignore: must_be_immutable
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
                authService.signInWithGoogle(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
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
                      const Text(
                        'Sign-in with Google',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
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
                      builder: (context) => const PhoneNumberVerification(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
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
                      Text('Sign-in with phone',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
