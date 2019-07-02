import 'dart:async';
import 'dart:convert';

import 'package:twitter/twitter.dart';
import 'package:http/http.dart' as http;
import '../models/influencer.dart';
import 'user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../environmrnt_variables.dart';

mixin InfluencerModel on ConnectedModel {
  List<Influencer> _influencers = [];
  Influencer _activeInfluencer;

  List<Influencer> get influencers => _influencers;

  Influencer get activeInfluencer => _activeInfluencer;
  List<String> _selectedUserCategories = [];
  List<String> friends = [];

  void selectInfluencer(int index) {
    _activeInfluencer = _influencers[index];
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

  removeFriend(String screenName){
    friends.remove(screenName);
  }

  addFriend(String screenName){
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

  //  'https://api.twitter.com/1.1/friendships/create.json?user_id=@mackenziebezos&follow=true'
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
}
