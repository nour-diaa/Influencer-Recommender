import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../enums/user_status.dart';
import '../scoped_model/main_model.dart';
import '../screens/home_page.dart';

class LoginButton extends StatelessWidget {
  final double width;
  final Function callBack;

  LoginButton({@required this.width, @required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () async {
            await model.login().then((_) {
              if (model.result == UserStatus.logged) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                print('########## failed &&&%&&#&(#@&');
                // TODO show error dialog
              }
            });
          },
          child: Container(
            width: width,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.blue,
                  Colors.deepPurple,
                ])),
            child: Center(
              child: Text(
                'Login with twitter',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
