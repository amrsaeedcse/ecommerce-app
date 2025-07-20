import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/signin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double opacity = 1;
  Duration opacityDuration = Duration(milliseconds: 200);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    Future.delayed(Duration(milliseconds: 800), () async {
      await _animationController.forward();
      await _animationController.reverse();
      setState(() {
        opacity = 0;
      });
      await Future.delayed(
        opacityDuration,
        () => setState(() {
          opacity = 1;
        }),
      );
      await Future.delayed(opacityDuration);
      await Future.delayed(Duration(milliseconds: 300));
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, w) {
            return ShaderMask(
              child: AnimatedOpacity(
                duration: opacityDuration,
                opacity: opacity,
                child: Image.asset("assets/images/logos/main.png"),
              ),
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.white],
                  stops: [_animationController.value, 0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
            );
          },
        ),
      ),
    );
  }
}
