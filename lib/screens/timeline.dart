import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model/main_model.dart';
import '../widgets/tweet_item.dart';


class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    initTweets();
  }

  Future<Null> initTweets() async {
    MainModel model = ScopedModel.of(context);
    if(model.tweets.length <=0)
      await model.getTweet();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.tweets.length <= 0
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: model.tweets.length,
                itemBuilder: (BuildContext context, int index) {
                  return TweetItem(model.tweets[index]);
                },
              );
      },
    );
  }
}
