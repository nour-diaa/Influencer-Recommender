import 'dart:async';
import 'dart:convert';

import '../models/tweet.dart';
import 'user_model.dart';
import 'package:twitter/twitter.dart';
import 'user_model.dart';

mixin TweetModel on ConnectedModel {
  List<Tweet> _tweets = [];
  List<Tweet> _profileTweets = [];

  List<Tweet> get tweets => _tweets;

  List<Tweet> get profileTweets => _profileTweets;

  // the worst practice ever made
  // god please forgive me
  int uFollowers = 0;
  int uLikes = 0;
  int uTweets = 0;

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
    uFollowers = res[0]['user']['followers_count'];
    uLikes = res[0]['user']['favourites_count'];
    uTweets = res[0]['user']['statuses_count'];
    print('values $uFollowers - $uLikes - $uTweets}');
    notifyListeners();
    for (int i = 0; i < res.length; i++) {
      _profileTweets.add(Tweet.fromJson(res[i]));
    }
    print("${_profileTweets.length} ++ ${_profileTweets[0].text}");
  }

  retweet(String id) async{
    final String url =
        'statuses/retweet/$id.json';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print('tweet retweeted ${res.toString()}');

  }

  unRetweet(String id) async{
    final String url =
        'statuses/unretweet/$id.json';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print('tweet retweeted ${res.toString()}');

  }

  like(String id) async{
    final String url =
        'favorites/create.json?id=$id';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print('tweet liked ${res.toString()}');

  }


  unLike(String id) async{
    final String url =
        'favorites/destroy.json?id=$id';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print('tweet unliked ${res.toString()}');

  }
}
