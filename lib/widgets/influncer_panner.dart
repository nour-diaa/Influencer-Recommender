import 'package:flutter/material.dart';
import 'package:influencer_recommender/models/influencer.dart';
import 'package:influencer_recommender/scoped_model/main_model.dart';
import 'package:influencer_recommender/screens/influncer_profile.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

class InfluencerBanner extends StatefulWidget {
  final Influencer influencer;

  InfluencerBanner({this.influencer});

  @override
  _ProfileBannerState createState() => _ProfileBannerState();
}

class _ProfileBannerState extends State<InfluencerBanner> {
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
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildInfo('followers',
                          model.activeInfluencer.followers.toString()),
                      buildInfo(
                          'Tweets', model.activeInfluencer.tweets.toString()),
                      buildInfo(
                          'likes', model.activeInfluencer.likes.toString()),
                    ],
                  );
                })
              ],
            ),
          ),
          buildPositionedFAB(),
          buildPositionedAvatar(_width, context)
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
              widget.influencer.name,
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            Text(widget.influencer.screenName)
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
            widget.influencer.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Positioned buildPositionedAvatar(double _width, BuildContext context) {
    return Positioned(
      top: 20,
      left: _width * 0.72,
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          onPressed: () {
            setState(() {
              if (model.friends.contains(model.activeInfluencer.screenName)) {
                model.unFollow(model.activeInfluencer.screenName);
                model.removeFriend(model.activeInfluencer.screenName);
              } else {
                model.follow(model.activeInfluencer.screenName);
                model.addFriend(model.activeInfluencer.screenName);
              }
            });
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: model.friends.contains(model.activeInfluencer.screenName)
              ? Icon(Icons.person)
              : Icon(Icons.person_add),
        );
      }),
    );
  }
}
