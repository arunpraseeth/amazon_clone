// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/auth/screens/home_screen.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created! Login with same credentials",
            false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          SharedPreferences sharedpref = await SharedPreferences.getInstance();
          sharedpref.setString(authToken, jsonDecode(response.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }

  void getUserData(BuildContext context) async {
    try {
      SharedPreferences sharedpref = await SharedPreferences.getInstance();
      String? token = sharedpref.getString(authToken);

      if (token == null) {
        sharedpref.setString(authToken, "authToken");
      }
      http.Response response = await http.post(
        Uri.parse("$uri/tokenIsValid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authToken': token!,
        },
      );
      var jsonData = jsonDecode(response.body);
      if (jsonData == true) {
        // GETTING USER DATA
        http.Response userResponse = await http.get(
          Uri.parse("$uri/api/userdata"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authToken': token,
          },
        );

        Provider.of<UserProvider>(context, listen: false)
            .setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), true);
    }
  }
}
