import 'package:flutter/material.dart';
import 'package:influencer_recommender/scoped_model/main_model.dart';
import 'package:influencer_recommender/widgets/influncer_panner.dart';
import 'package:influencer_recommender/widgets/tweet_item.dart';
import 'package:scoped_model/scoped_model.dart';

class InfluencerProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfluencerProfileState();
  }
}

class _InfluencerProfileState extends State<InfluencerProfile> {
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              photo(model.activeInfluencer.banner ?? 'assets/pics/header3.jpg'),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  SizedBox(
                    height: /*330*/ _width < 600
                        ? _height * 0.3
                        : _height * 0.25,
                  ),
                  InfluencerBanner(
                    influencer: model.activeInfluencer,
                  ),
                  SizedBox(height: 50),
                  ListView.builder(
                    physics: ClampingScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    itemCount: model.influencerTweets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TweetItem(model.influencerTweets[index]);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget photo(String url) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    return Container(
      height: _width < 600 ? _height * 0.7 : _height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        image: DecorationImage(
          image: url.startsWith('assets') ? AssetImage(url) : NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
