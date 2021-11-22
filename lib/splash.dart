import 'package:face_filters/cam_masks_filters.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image.asset("images/icon.png"),
      photoSize: 140,
      loaderColor: Colors.deepPurple,
      loadingText: const Text(
        "by Praveen Varma",
        style: TextStyle(
          color: Colors.deepPurpleAccent,
          fontSize: 16,
          fontFamily: "Brand Bold",
        ),
      ),
      backgroundColor: Colors.white,
      seconds: 5,
      navigateAfterSeconds: CameraMasksFilters(),
      title: const Text(
        "AR   Face   Filters",
        style: TextStyle(
          fontSize: 50,
          color: Colors.deepPurpleAccent,
          fontFamily: "Signatra",
        ),
      ),
    );
  }
}
