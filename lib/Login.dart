import 'package:flutter/material.dart';
import 'package:merge_capl/aman/bottom_nav.dart';
import 'SignUp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'integration/api/basics_api.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Uri _urlFB = Uri.parse("https://www.facebook.com/login/");

  final Uri _urlGoogle = Uri.parse(
      "https://accounts.google.com/v3/signin/identifier?continue=https%3A%2F%2Faccounts.google.com%2F&followup=https%3A%2F%2Faccounts.google.com%2F&ifkv=Ab5oB3rLC82jZdK_Rn9ZIGx-Y0m6xw-E3pasF0vtI1ZmtvWmEVG1RQ82oqfe7teAXkQvmV7FiF0Ibw&passive=1209600&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S287277681%3A1723466158471857&ddm=0");
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_back.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double screenWidth = constraints.maxWidth;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Crick Age',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Login to your account',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: screenWidth < 300 ? screenWidth * 0.8 : 300,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return "please Enter your Phone";
                            }
                            return null;
                          },
                          controller: phoneController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                                Icons.account_circle, color: Colors.white),
                            hintText: 'Phone',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: screenWidth < 300 ? screenWidth * 0.8 : 300,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Enter Your Password";
                            }
                            return null;
                          },
                          controller: passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                                Icons.lock, color: Colors.white),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            fillColor: Colors.white.withOpacity(0.1),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: screenWidth < 300 ? screenWidth * 0.8 : 300,
                        child: ElevatedButton(
                          onPressed: () {
                            BasicsApi object = BasicsApi();
                          final response = object.loginApi(phoneController.text, passwordController.text, context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: const Color(0xFF3b3b6d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            style: TextStyle(fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                            'Login',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account? Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.15,
                            child: IconButton(
                                icon: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                      'assets/images/google.png'),
                                ),
                                onPressed: () {
                                  launchUrl(_urlGoogle);
                                }
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                            child: IconButton(
                              icon: Icon(
                                Icons.facebook, color: Colors.blue, size: 30,),
                              onPressed: () {
                                launchUrl(_urlFB);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


}