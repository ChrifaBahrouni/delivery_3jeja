import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/partenaire_screen.dart';
import 'package:delivery_3jeja/screens/coursie/main_coursie.dart';
import 'package:delivery_3jeja/screens/main_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/error_handling.dart';
import '../config/global_variables.dart';
import '../config/utils.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required int phone,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        phone: phone,
        adresse: [],
        type: 'user',
        token: '',
        avatar: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/users/user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          String userType =
              Provider.of<UserProvider>(context, listen: false).user.type;
          print(" type user " + userType);
          if (userType == 'user') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainScreen.routeName,
              (route) => false,
            );
          } else if (userType == 'bayer') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              PartenaireScreen.routeName,
              (route) => false,
            );
          } else if (userType == 'coursie') {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainCoursie.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
//edit profil

  void UpdateUser({
    required BuildContext context,
    required File avatar,
    required int phone,
    required String name,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('deztsmo9g', 'rttteggd');
      String imageUrl = "";
    
      CloudinaryResponse res1 = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(avatar.path, folder: name),
      );
      imageUrl = res1.secureUrl; 
      /* final userProvider = Provider.of<UserProvider>(context, listen: false);
  User user = userProvider.user ; 
   user.name =name;  
   user.avatar = imageUrl ; 
   user.phone = phone ; 
*/

        User user = User(
        id: '',
        name: name,
        password: '',
        email: '',
        adresse: [],
        avatar: imageUrl,
        phone: phone,
        type: '',
        token: '',
        cart: [],
      );
 
      http.Response res = await http.post(
        Uri.parse('$uri/users/user/?id${user.id}'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account updated! ',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
//upload image
}
