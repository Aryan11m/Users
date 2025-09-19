import 'dart:async';
import 'package:get/get.dart';
import 'package:firsttask/screen/homepage.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> 
with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(vsync: this,
  duration: const Duration(seconds: 3)
  )..repeat(reverse: true);
  late final Animation<double> _animation=CurvedAnimation(
    parent: _controller, curve: Curves.fastOutSlowIn
  );

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Get.off(() => Homepage());
    });
  }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Invento',
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 61, 60, 60),
                    ),
                  ],
                ),
              ),
            ),
          ),         
        ),
      ),
    );
  }
}