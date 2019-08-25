import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // declare the instance variables, but don't initialize them
  Animation<double> catAnimation;
  AnimationController catController;

  // Lec. 185
  // lifecycle method - automatically invoked with instantiate a HomeState
  // only available for classes that extend the State class
  initState() {
    super.initState();

    // Lec. 186
    // passing 'this' into vsync argument, the TickerProvider is mixed-in
    // to the current class
    // catController can start, stop, and restart animation
    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    catAnimation = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
      parent: catController,
      curve: Curves.easeIn,
    ));
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
  }

  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation!'),
        ),
        body: GestureDetector(
          child: Center(
              child: Stack(
                children: <Widget>[
                  buildCatAnimation(),
                  buildBox(),
                ],
              )
            ),
          onTap: onTap
        )
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Container(
            child: child, margin: EdgeInsets.only(top: catAnimation.value));
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }
}
