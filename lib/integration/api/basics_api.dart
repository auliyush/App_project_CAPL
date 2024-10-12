import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/aman/audience/audience_accouts.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../Login.dart';
import '../../aman/audience/audience_bottom.dart';
import '../../aman/bottom_nav.dart';
import '../../aman/player/player_bottam.dart';
import '../data_classes/admin_get_response.dart';
import '../data_classes/login_response.dart';
import '../providers/login_provider.dart';

class BasicsApi {
  final signUpUrl = "http://localhost:8080/app/signUp";
  final loginUrl = "http://localhost:8080/app/login";
  final accountUrl = "http://localhost:8080/admin/byId";
  final createTeamUrl = "http://localhost:8080/capl/team/create/Team";
  static const getApiUrl = "http://localhost:8080/capl/user/logged/in/user/Id";

 static String? loggedId;
 static String? loggedRole;

  // this api for SignUp my provided data on mongo repository...
  Future<void> signUpApi(String userName, String userPhone, String userEmail,
      String userPassword, String userRole, BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(signUpUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "userName": userName,
            "userPhone": userPhone,
            "userEmail": userEmail,
            "userPassword": userPassword,
            "userRole": userRole
          }));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );
      print("$e");
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid response from server')),
      );
    } catch (e) {
      print('Unknown Error: $e'); // it is use for the error print in console
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An unknown error occurred. Please try again.')),
      );
    }
  }

  Future<LoginResponse?> loginApi(String phoneNumber, String password,
      BuildContext context) async {
    try {
      final uri = Uri.parse(loginUrl).replace(queryParameters: {
        "phoneNumber": phoneNumber,
        "password": password,
      });

      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonData);
        Provider.of<LoginProvider>(context, listen: false).updateLoginResponse(loginResponse);
        loggedId = loginResponse.creatorId;
        loggedRole = loginResponse.role;
        if (loginResponse.role.toLowerCase() == "admin") {
          getUserId(phoneNumber, password);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNav()));
        } else if (loginResponse.role.toLowerCase() == "player") {
          getUserId(phoneNumber, password);
          // call here player nav
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PlayerBottom()));
        } else {
          getUserId(phoneNumber, password);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AudienceBottom()));
        }
        // for using creator id in anywhere of my pages...
        Provider.of<LoginProvider>(context, listen: false)
            .updateLoginResponse(loginResponse);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
        // for checking data is coming from server or not..
        // print(loginResponse.creatorId);
        // print(loggedRole);
        // print(loggedId);
        // print(loginResponse.role);
        return loginResponse;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text('Failed to login. Status code: ${response.statusCode}')),
        );
        return null;
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
      return null;
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
      return null;
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
      return null;
    }
  }

  Future<AdminGetResponse?> getAccountAdmin(BuildContext context) async {

    if (loggedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login first')),
      );
      return null;
    }
    try {
      final response = await http.get(
          Uri.parse(accountUrl).replace(queryParameters: {
            "adminId": loggedId
          }));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final adminResponse = AdminGetResponse.fromJson(jsonData);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AudienceAccountPage(
                playerPhotoUrl: adminResponse.profilePhoto,
                playerName: adminResponse.username,
                playerMobNumber: adminResponse.phone,
                playerEmail: adminResponse.email,
                playerGender: "MALE")));
        return adminResponse;
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Network Error : $e")));
      return null;
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );
      return null;
    } catch (e) {
      print('Unknown Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );
      return null;
    }

    return null;
  }

  Future<void> getUserId(String userPhone, String userPassword) async {
    try {

      final response = await http.get(Uri.parse(getApiUrl).replace(queryParameters: {
        'userPhone': userPhone,
        'userPassword': userPassword,
      }));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('adminId')) {
          final adminId = jsonData['adminId'];
          if (adminId != null && adminId.isNotEmpty) {
            loggedId = adminId.trim(); // Trim any extra spaces
            print("Logged userId: $loggedId");
          } else {
            print("adminId is null or empty");
          }
        } else {
          print("'adminId' not found in the response JSON");
        }
      } else {
        print("Failed to get user ID: ${response.statusCode}");
      }
    } catch (e) {
      print('Unknown Error: $e'); // Log the error
    }
  }




  Future<void> createTeam(String teamName, String teamNickName, String teamPhotoUrl, BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(createTeamUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "teamCreatorId": loggedId,
            "teamName": teamName,
            "teamNickName": teamNickName,
            "teamProfilePhotoUrl" : teamPhotoUrl
          }));

      if (response.statusCode == 200) {
        Navigator.pop(context);
      }
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e')),
      );// rethrow the exception
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid response from server')),
      );// rethrow the exception
    } catch (e) {
      print('Unknown Error: $e'); // log the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unknown error occurred. Please try again.')),
      );// rethrow the exception
    }
  }
}
