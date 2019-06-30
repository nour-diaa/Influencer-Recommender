import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'settings page',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 40,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
