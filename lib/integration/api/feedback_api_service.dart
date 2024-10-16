import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/login_provider.dart';

class FeedbackApiService {
  final feedbackUrl = "http://localhost:8080/Feedback/createFeedback";

  Future<void> createFeedbackApi (String feedbackDescription, BuildContext context) async {
    DateTime now = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(now);

    // final timeFormat = DateFormat('HH:mm:ss');
    // final formattedTime = timeFormat.format(now);

    try {
      final counter = Provider.of<LoginProvider>(
        context,
        listen: false,
      ).loginResponse?.signInId;
      final response = await http.post(Uri.parse(feedbackUrl),
          headers: {
            'Content-Type': 'application/json',
          } ,
        body: jsonEncode({
          "userId" : counter,
          "feedbackSubmitDate" : formattedDate,
          // "feedbackSubmitTime" : formattedTime,
          "feedbackDescription" : feedbackDescription
        }),
      );
      if(response.statusCode == 200) {
        print('logged Id : $counter');
        if (context.mounted) { // Check if widget is still mounted
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully Feedback Submitted')),
          );
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong Try Again')),
            );
          }
        }
      }
    } on http.ClientException catch (e) {
      print('ClientException Occurred : $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something Went Wrong')),
        );
      }
    } on FormatException catch (e) {
      print('FormatException Occurred : $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something Went Wrong')),
        );
      }
    } catch (e) {
      print('Unknown Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unknown error occurred. Please try again.')),
        );
      }

    }

  }


}