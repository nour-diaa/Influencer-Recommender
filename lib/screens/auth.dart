import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

import '../widgets/login_button.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _animationName = 'success';
  String _message = '';
  String _message2 = '';
  FlareController controller;
  bool _completedLogin = false;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: _width,
          height: _height,
          child: FlareActor(
            'assets/flare/intro.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            controller: controller,
            animation: _animationName,
            callback: (_) {
              setState(() {
                _message = 'Influencer recommender';
                _message2 = 'we get the best out of twitter for you';
              });
            },
          ),
        ),
        Positioned(
          top: _height * 0.15,
          left: _width * 0.1,
          child: Container(
            width: _width * 0.8,
            child: Column(
              children: <Widget>[
                Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _message2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: _width * 0.1,
          top: _height * 0.85,
          child: LoginButton(width: _width * 0.8, callBack: completeLogin),
        ),
      ],
    ));
  }

  void completeLogin() {
    setState(() {
      _completedLogin = true;
    });
  }
}
