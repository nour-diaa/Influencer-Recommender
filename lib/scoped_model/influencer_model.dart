import 'dart:async';
import 'dart:convert';

import 'package:twitter/twitter.dart';
import '../models/influencer.dart';
import 'user_model.dart';

mixin InfluencerModel on ConnectedModel {
  List<Influencer> _influencers = initInfluencers();
  Influencer _activeInfluencer;

  List<Influencer> get influencers => _influencers;

  Influencer get activeInfluencer => _activeInfluencer;

  void selectInfluencer(int index) {
    _activeInfluencer = _influencers[index];
    notifyListeners();
  }

  static List<Influencer> initInfluencers() {
    List<Influencer> influencers = [];
    influencers.add(Influencer(
        name: 'Sara Soueidan',
        screenName: '@SaraSoueidan',
        imageUrl:
            'https://pbs.twimg.com/profile_images/1010126354078208001/MpkO7-qK_400x400.jpg'));
    influencers.add(Influencer(
        name: 'Coding in Flow',
        screenName: '@codinginflow',
        imageUrl:
            'https://pbs.twimg.com/profile_images/1036358716113776646/vAsy3c6T_400x400.jpg'));
    influencers.add(Influencer(
        name: 'Joe Birch',
        screenName: '@hitherejoe',
        imageUrl:
            'https://pbs.twimg.com/profile_images/994775275153092608/-rGSy4tT_400x400.jpg'));
    influencers.add(Influencer(
        name: 'sia',
        screenName: '@Sia',
        imageUrl:
            'https://pbs.twimg.com/profile_images/991029660795490310/pRM6eP6u_400x400.jpg'));
    influencers.add(Influencer(
        name: 'Lewis Hilsenteger',
        screenName: '@UnboxTherapy',
        imageUrl:
            'https://pbs.twimg.com/profile_images/948769241443942401/tL1_qwMz_400x400.jpg'));
    influencers.add(Influencer(
        name: 'Philipp Csernalabics',
        screenName: '@csernalabics',
        imageUrl:
            'https://pbs.twimg.com/profile_images/1044648277545832455/7BjzJUuh_400x400.jpg'));

    influencers.add(Influencer(
        name: 'Medium',
        screenName: '@Medium',
        imageUrl:
            'https://pbs.twimg.com/profile_images/900033008685666305/c6Q38U35_400x400.png'));

    return influencers;
  }

  //  'https://api.twitter.com/1.1/friendships/create.json?user_id=@mackenziebezos&follow=true'
  Future<bool> follow(String screenName) async{
    final String url = 'friendships/create.json?screen_name=$screenName&follow=true';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print(res.toString());
  }

  Future<bool> unFollow(String screenName) async{
    final String url = 'friendships/destroy.json?screen_name=$screenName&follow=true';
    Twitter twitter =
    new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("POST", url);
    var res = json.decode(response.body);
    print(res.toString());
  }

}
