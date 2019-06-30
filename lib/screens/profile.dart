import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model/main_model.dart';
import '../widgets/profile_panner.dart';
import '../widgets/tweet_item.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    initTweets();
  }

  Future<Null> initTweets() async {
    MainModel model = ScopedModel.of(context);
    if (model.profileTweets.length <= 0) await model.getTimelineTweet();
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            photo(model.currentUser.banner ?? 'assets/pics/header3.jpg'),
            ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                SizedBox(
                  height: /*330*/ _width < 600 ? _height * 0.3 : _height * 0.25,
                ),
                ProfileBanner(
                  person: model.currentUser,
                ),
                SizedBox(height: 100),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  primary: true,
                  shrinkWrap: true,
                  itemCount: model.profileTweets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TweetItem(model.profileTweets[index]);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget photo(String url) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Container(
        height: /*600*/ _width < 600 ? _height * 0.7 : _height * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            image: DecorationImage(
              image: url.startsWith('assets')
                  ? AssetImage(url)
                  : NetworkImage(url),
              fit: BoxFit.cover,
            )));
  }
}
