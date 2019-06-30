import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileBanner extends StatefulWidget {
  final User person;

  ProfileBanner({this.person});

  @override
  _ProfileBannerState createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<ProfileBanner> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      width: _width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
      child: Stack(
        children: <Widget>[
          Container(
            height: 155,
            width: _width * 0.9,
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withOpacity(0.7),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                buildNameDescription(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildInfo('followers', '20K'),
                    buildInfo('following', '12K'),
                    buildInfo('likes', '500'),
                  ],
                )
              ],
            ),
          ),
          buildPositionedFAB(),
        ],
      ),
    );
  }

  Row buildNameDescription() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 105,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.person.name,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            Text(widget.person.screenName)
          ],
        ),
      ],
    );
  }

  Widget buildInfo(String name, String value) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Text(name),
      ],
    );
  }

  Positioned buildPositionedFAB() {
    return Positioned(
      top: 20,
      left: 15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Container(
          width: 85,
          height: 85,
          child: Image.network(
            widget.person.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }


}
