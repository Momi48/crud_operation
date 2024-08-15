import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/login/login_screen.dart';
import 'package:flutter_assignment/screens/post_screen.dart';

class Splash {
  void isLogin(BuildContext context) {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user != null) {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostScreen()));
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      }
    
  }
}
