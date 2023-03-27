import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore_services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future<String?> getAccessToken() async {
    String? accessToken;
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      accessToken = localStorage.getString("accessToken");
      return accessToken;
    } catch (e) {
      return null;
    }
  }

  static Future<void> signInWithGoolgle(BuildContext context) async {
    try {
      final SharedPreferences localStorage =
          await SharedPreferences.getInstance();
      final GoogleSignInAccount? servicesRes =
          await GoogleSignIn.standard(scopes: ["email"]).signIn();
      if (servicesRes == null) {
        throw Exception('Failed To Sign in');
      } else {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await servicesRes.authentication;
        final String? accessToken = googleSignInAuthentication.accessToken;
        if (accessToken == null) {
          throw Exception('Failed to Login Access Token Was Null');
        } else {
          localStorage.setString("accessToken", accessToken);
          log(servicesRes.photoUrl.toString());
          final UserProfile? userProfile =
              await FirestoreServices.getUserProfile(servicesRes.email);
          if (userProfile != null) {
            log(userProfile.tel.toString());
            if (userProfile.isAdmin == true) {
              GoRouter.of(context).pushReplacement('/admin');
            } else {
              GoRouter.of(context).pushReplacement('/');
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
      return;
    }
  }

  static Future<void> validateLogin(BuildContext context) async {
    try {
      bool isCurrentLoggedIn =
          await GoogleSignIn.standard(scopes: ["email"]).isSignedIn();
      log(isCurrentLoggedIn.toString());

      if (isCurrentLoggedIn) {
        GoRouter.of(context).pushReplacement('/');
      }
    } catch (e) {}
  }
}
