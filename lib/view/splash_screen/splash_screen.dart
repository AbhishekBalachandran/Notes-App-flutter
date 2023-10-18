import 'package:flutter/material.dart';
import 'package:notes_app/utils/color-constants/color-constants.dart';
import 'package:notes_app/utils/image_constants/image_constants.dart';
import 'package:notes_app/view/notelist-screen/notelist-screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoteListScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Image.asset(
          ImageConstants.takeNoteGif,
          width: MediaQuery.of(context).size.width * 0.8,
        )),
      ]),
    );
  }
}
