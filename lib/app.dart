import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'screens/home_page.dart';
import 'screens/auth.dart';
import 'scoped_model/main_model.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Influencer recommender',
        theme: ThemeData(
          primaryColor: Color(0xff15A8F6),
          primaryColorDark: Color(0xff1FA6D1),
          primaryColorLight: Color(0xff15D3EF),
          primaryColorBrightness: Brightness.light
        ),
        home: AuthPage(),
      ),
    );
  }
}
