import 'dart:async';
import 'dart:convert';

import '../models/tweet.dart';
import 'user_model.dart';
import 'package:twitter/twitter.dart';

mixin TweetModel on ConnectedModel {
  List<Tweet> _tweets = [];
  List<Tweet> _profileTweets = [];

  List<Tweet> get tweets => _tweets;

  List<Tweet> get profileTweets => _profileTweets;

  Future<Null> getTweet() async {
    final String url =
        'statuses/home_timeline.json?count=40&exclude_replies=true&tweet_mode=extended';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    print(res.runtimeType);
    for (int i = 0; i < res.length; i++) {
      _tweets.add(Tweet.fromJson(res[i]));
    }

    notifyListeners();
    print("${_tweets.length} ++ ${_tweets[0].text}");
  }

  Future<Null> getTimelineTweet() async {
    final String url =
        'statuses/user_timeline.json?count=40&exclude_replies=true&tweet_mode=extended';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    print(res.runtimeType);
    for (int i = 0; i < res.length; i++) {
      _profileTweets.add(Tweet.fromJson(res[i]));
    }

    notifyListeners();
    print("${_profileTweets.length} ++ ${_profileTweets[0].text}");
  }
}
