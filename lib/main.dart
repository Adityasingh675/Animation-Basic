import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);

    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      },
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedLogo(
        animation: _animation,
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Tween<double> _sizeAnimation = Tween<double>(begin: 0.0, end: 500.0);
  AnimatedLogo({Key key, Animation animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> _animation = listenable;
    return Transform.scale(
      scale: _animation.value * 10,
      child: FlutterLogo(),
    );
  }
}
