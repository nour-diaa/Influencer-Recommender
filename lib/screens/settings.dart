import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main_model.dart';
import 'auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  MainModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of<MainModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Logout'),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthPage()));
          },
        ),
        ListTile(
          title: Text('unselect all categories'),
          leading: Icon(Icons.close),
          onTap: () {
            model.unSelectAllCategories();
          },
        ),
        ListTile(
          title: Text('select all categories'),
          leading: Icon(Icons.check),
          onTap: () {
            model.selectAllCats();
          },
        ),
      ],
    );
  }

}
