import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merge_capl/adminScreens/admin_bottom_nav.dart';
import 'package:merge_capl/integration/api/player_more_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../start/Login.dart';
import '../../more_screens/accounts/account_screen.dart';
import '../../navigation/bottom_nav_screen.dart';
import '../providers/login_provider.dart';
import '../response_classes/admin_get_response.dart';
import '../response_classes/login_response.dart';

class ApiServices {
  final signUpUrl = "http://localhost:8080/app/signUp";
  final loginUrl = "http://localhost:8080/app/login";
  final adminAccountUrl = "http://localhost:8080/admin/byId";
  final userAccountUrl = "http://localhost:8080/capl/user/getUser/ById";
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
            SnackBar(content: Text('Not Worked')),
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
              context, MaterialPageRoute(builder: (context) => AdminBottomNav()));
        } else {
          getUserId(phoneNumber, password);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserBottomNav()));
        }
        Provider.of<LoginProvider>(context, listen: false)
            .updateLoginResponse(loginResponse);
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
          Uri.parse(adminAccountUrl).replace(queryParameters: {
            "adminId": loggedId
          }));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final adminResponse = AdminGetResponse.fromJson(jsonData);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AccountScreen(
                userName: adminResponse.username,
                userMobNumber: adminResponse.phone,
                userEmail: adminResponse.email,
                userGender: "MALE")
        ));
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

  Future<UserGetResponse?> getUserAccount(BuildContext context) async {

    if (loggedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login first')),
      );
      return null;
    }
    try {
      final response = await http.get(
          Uri.parse(userAccountUrl).replace(queryParameters: {
            "userId": loggedId
          }));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final userResponse = UserGetResponse.fromJson(jsonData);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            AccountScreen(
                userName: userResponse.username,
                userMobNumber: userResponse.phone,
                userEmail: userResponse.email,
                userGender: "MALE")
        ));
        return userResponse;
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

  void navigateToAccounts (BuildContext context) {
    if(loggedRole?.toLowerCase() == "user") {
      getUserAccount(context);
    } else if(loggedRole?.toLowerCase() == "admin")  {
      getAccountAdmin(context);
    } else {
      PlayerMoreAccount obj = PlayerMoreAccount();
      obj.playerDataApi(context);
    }
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
