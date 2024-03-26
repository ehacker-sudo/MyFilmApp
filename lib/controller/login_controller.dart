import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfilmapp/model/message.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Future<Message> register(User user) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'confirm_password': user.confirmPassword,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final results = jsonDecode(response.body) as Map<String, dynamic>;
      // var token = results["access_token"];
      // print(token);
      // final SharedPreferences prefs = await _pref;
      // await prefs.setString('token', token);
      // nameController.clear();
      // emailController.clear();
      // passwordController.clear();
      return Message.fromJson(results);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Register.');
    }
  }
}
