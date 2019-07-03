import 'package:flutter/material.dart';

import '../widgets/categories_grid.dart';
import '../widgets/categories_search_field.dart';

class CategoriesRoute extends StatefulWidget {
  @override
  _CategoriesRouteState createState() => _CategoriesRouteState();
}

class _CategoriesRouteState extends State<CategoriesRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepPurple,
            Colors.blue,
            Colors.blue,
            Colors.blue,
            Colors.deepPurple,
          ]),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            CategoriesGrid(),
          ],
        ));
  }
}