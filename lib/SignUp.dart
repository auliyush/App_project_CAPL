import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:merge_capl/Login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


// 22:27 ----- 47%

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final apiUrl = "http://localhost:8080/capl/user/signUp";
  final _formKey = GlobalKey<FormState>();
  final Uri _urlFB = Uri.parse("https://www.facebook.com/login/");
  final Uri _urlGoogle = Uri.parse("https://accounts.google.com/v3/signin/identifier?continue=https%3A%2F%2Faccounts.google.com%2F&followup=https%3A%2F%2Faccounts.google.com%2F&ifkv=Ab5oB3rLC82jZdK_Rn9ZIGx-Y0m6xw-E3pasF0vtI1ZmtvWmEVG1RQ82oqfe7teAXkQvmV7FiF0Ibw&passive=1209600&flowName=GlifWebSignIn&flowEntry=ServiceLogin&dsh=S287277681%3A1723466158471857&ddm=0");

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_back.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
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
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
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
                              'Sign up to get started!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: userNameController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person, color: Colors.white),
                                  hintText: 'Name',
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
                              width: 300,
                              child: TextFormField(
                                controller: phoneController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = RegExp(pattern);
                                  if (value!.isEmpty) {
                                    return 'Enter Your mobile number';
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone, color: Colors.white),
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
                              width: 300,
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your Email';
                                  } else if (!EmailValidator.validate(value)) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                                  hintText: 'Email',
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
                              width: 300,
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your Password';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
                              width: 300,
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Your Confirm Password';
                                  }
                                  return null;
                                },
                                controller: confirmPasswordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                                  hintText: 'Confirm Password',
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
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (passwordController.text != confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Passwords do not match')),
                                    );
                                  } else if (_formKey.currentState!.validate()) {
                                    createSignUpRequest();

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: const Color(0xFF3b3b6d),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Already have an account? Login',
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
                                      child: Image.asset('assets/images/google.png'),
                                    ),
                                    onPressed: () {
                                      launchUrl(_urlGoogle);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.15,
                                  child: IconButton(
                                    icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
                                    onPressed: () {
                                      launchUrl(_urlFB);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Future<void> createSignUpRequest() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "userName": userNameController.text,
          "userPhone": phoneController.text,
          "userEmail": emailController.text,
          "userPassword": confirmPasswordController.text
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }




}
