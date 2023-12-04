import 'package:flutter/material.dart';
import 'package:food_app/home/screen_home.dart';
import 'package:food_app/services/auth_services.dart';

class PhoneNumberVerification extends StatefulWidget {
  PhoneNumberVerification({super.key});

  @override
  State<PhoneNumberVerification> createState() =>
      _PhoneNumberVerificationState();
}

class _PhoneNumberVerificationState extends State<PhoneNumberVerification> {
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _otpController = TextEditingController();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/image/vrfy.jpg')),
          Text(
            'Sign-in with phone',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text('Enter You Phone number to continue'),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _phoneController,
            decoration: InputDecoration(
                prefixText: '+91 ',
                labelText: 'Enter you phone number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            validator: (value) {
              if (value!.length != 10) return 'Invalid phone number';
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)),
              onPressed: () {
                authService.sentOtp(
                    phone: _phoneController.text,
                    errorStep: () =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error in sending OTP'),
                          backgroundColor: Colors.red,
                        )),
                    nextStep: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('OTP Vrification'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter 6 digit OTP'),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _otpController,
                                decoration: InputDecoration(
                                    labelText: 'Enter you OTP',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                validator: (value) {
                                  if (value!.length != 6)
                                    return 'Invalid phone number';
                                  return null;
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  authService
                                      .loginWithOtp(otp: _otpController.text)
                                      .then((value) {
                                    if (value == "Success") {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ScreenHome(),
                                          ));
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(value),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  });
                                },
                                child: Text('Submit'))
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                'Send OTP',
                style: TextStyle(color: Colors.white),
              )),
          TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              label: Text('Back'))
        ],
      ),
    );
  }
}
