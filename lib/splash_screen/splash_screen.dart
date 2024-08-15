import 'package:flutter/material.dart';
import 'package:flutter_assignment/splash_screen/splash_class.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splash splash = Splash();

  @override
  void initState() {
    super.initState();
    splash.isLogin(context);
  }
 
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfff7a34a),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitRing(color: Colors.white,
        size: 50.0,
        ),
        // SizedBox(height: 5,),
        // Center(child: Text('Loading Please Wait',style: TextStyle(fontWeight: FontWeight.bold),))
      ],
    ));
  }
}
