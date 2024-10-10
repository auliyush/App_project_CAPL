import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../aman/bottom_nav.dart';
import '../../hold_models/items/team_data.dart';

class ApiService {
  static const loginUrl = "http://localhost:8080/capl/user/signIn";

  Future<void> signInRequest(String userPhone, String userPassword, BuildContext context) async {
    try {

      final uri = Uri.parse(loginUrl).replace(queryParameters: {
        'userPhone': userPhone,
        'userPassword': userPassword,
      });
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else {
          print("Authentication failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Authentication failed')),
          );
        }
      } else {
        print("Server error: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } on http.ClientException catch (e) {
      print("Network error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
    } on FormatException catch (e) {
      print("Invalid response: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
    } catch (e) {
      print("Unknown Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }

}