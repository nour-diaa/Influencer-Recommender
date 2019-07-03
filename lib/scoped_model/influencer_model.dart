import 'dart:async';
import 'dart:convert';

import 'package:influencer_recommender/models/tweet.dart';
import 'package:twitter/twitter.dart';
import 'package:http/http.dart' as http;
import '../models/influencer.dart';
import 'user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environmrnt_variables.dart';

mixin InfluencerModel on ConnectedModel {
  List<Influencer> _influencers = [];
  Influencer _activeInfluencer;
  List<Tweet> _influencerTweets = [];

  List<Influencer> get influencers => _influencers;

  Influencer get activeInfluencer => _activeInfluencer;
  List<String> _selectedUserCategories = [];
  List<String> friends = [];

  List<Tweet> get influencerTweets => _influencerTweets;

  void selectInfluencer(int index) {
    _influencerTweets=[];
    _activeInfluencer = _influencers[index];
    _getBanner();
    _getInfluncerProfileContentTweets();
    notifyListeners();
  }

  Future<bool> initInfluencers() async {
    if (_influencers.length > 0) return true;
    await getUserFriends();
    print('got friends');
    await getUserCats();
    for (String cat in _selectedUserCategories) {
      final String url = Environment.influencersUrl + '/$cat';
      http.Response response = await http.get(url);
      var res = json.decode(response.body);
      print(res.toString());
      for (var i in res) {
        _influencers.add(Influencer.fromJson(i));
      }
    }
    return true;
  }

  getUserFriends() async {
    String url =
        'friends/list.json?screen_name=$mScreenName&count=50&skip_status=true&include_user_entities=false';
    print('requeest url $url');
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    print('request sent');
    var res = json.decode(response.body);
    for (var i in res['users']) {
      friends.add(i['screen_name']);
    }
    print(res.toString());
  }

  removeFriend(String screenName) {
    friends.remove(screenName);
  }

  addFriend(String screenName) {
    friends.add(screenName);
  }

  getUserCats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cats = prefs.getString('cats') ?? '#0';
    print('got string here $cats');
    var ids = cats.split('#');
    ids.removeAt(0);
    print('ids ${ids.toString()}');
    _selectedUserCategories.clear();
    print('check clear');
    for (String s in ids) {
      print('cats $s');
      _selectedUserCategories.add(s);
    }
  }

  Future<bool> follow(String screenName) async {
    final String url =
        'friendships/create.json?screen_name=$screenName&follow=true';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print(res.toString());
  }

  Future<bool> unFollow(String screenName) async {
    final String url =
        'friendships/destroy.json?screen_name=$screenName&follow=true';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print(res.toString());
  }

  Future<Null> _getBanner() async {
    final String url =
        'users/profile_banner.json?screen_name=${_activeInfluencer.screenName}';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    print('${res.toString()}  the screen name is here ');
    _activeInfluencer.banner = res['sizes']['mobile']['url'];
  }

  Future<Null> _getInfluncerProfileContentTweets() async {
    final String url =
        'statuses/user_timeline.json?screen_name=${_activeInfluencer.screenName}&count=40';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    _activeInfluencer.followers = res[0]['user']['followers_count'];
    _activeInfluencer.likes = res[0]['user']['favourites_count'];
    _activeInfluencer.tweets = res[0]['user']['statuses_count'];
    notifyListeners();

    for (int i = 0; i < res.length; i++) {
      _influencerTweets.add(Tweet(
        created_at: res[i]['created_at'],
        text: res[i]['text'],
        description: res[i]['description'],
        favourites_count: res[i]['user']['favourites_count'],
        followers_count: res[i]['user']['followers_count'],
        hashtags: res[i]['hashtags'],
        id_str: res[i]['id_str'],
        location: res[i]['user']['location'],
        name: _activeInfluencer.name,
        profile_background_image_url_https: res[i]['user']['profile_background_image_url_https'],
        profile_image_url: _activeInfluencer.imageUrl,
        retweet_count: res[i]['retweet_count'],
        screen_name: _activeInfluencer.screenName,
        urls: ['sdd', 'sdsd'],
        user_mentions: ['sds', 'sds'],
        verified: true,
      ));
    }

  }
}
