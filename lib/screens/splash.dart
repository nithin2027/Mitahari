//not required now see later
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     Duration(seconds: 6),
    //     () => Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => temp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Container(
              constraints: const BoxConstraints.expand(height: 300.0),
              decoration: const BoxDecoration(color: Colors.grey),
              child: Image.asset(
                "assets/icons/logo.jpg",
                fit: BoxFit.cover,
              )),
          Marquee(
            textDirection: TextDirection.rtl,
            animationDuration: const Duration(seconds: 1),
            backDuration: const Duration(milliseconds: 5000),
            pauseDuration: const Duration(milliseconds: 2500),
            directionMarguee: DirectionMarguee.oneDirection,
            child: const Text(
              "Healthy Choices, Simplified",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
              // pauseAfterRound: Duration(seconds: 1)
            ),
          ),
          Container(
            child: const Text('MITIHARI',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ])));
  }
}
