import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class User {
  final String userId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String userPassword;
  final String userProfilePhotoUrl;

  User({
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.userPassword,
    required this.userProfilePhotoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      userEmail: json['userEmail'],
      userPassword: json['userPassword'],
      userProfilePhotoUrl: json['userProfilePhotoUrl'],
    );
  }
}


class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      // Parse the JSON into a list of Users
      List<dynamic> body = jsonDecode(response.body);
      List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
      return users;
    } else {
      // Throw an exception if the server returns an error
      throw Exception('Failed to load users');
    }
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> futureUsers;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080/capl/user/listOf/User'); // Update with your local server URL

  @override
  void initState() {
    super.initState();
    futureUsers = apiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Demo'),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<User>? users = snapshot.data;
              return ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text(users[index].userName),
                    subtitle: Text(users[index].userEmail),
                  );
                },
              );
            } else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}

