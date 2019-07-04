import 'dart:async';
import 'dart:convert';

import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:twitter/twitter.dart';

import '../enums/user_status.dart';
import '../models/user.dart';

mixin ConnectedModel on Model {
  String mConsumerKey = 'ADD_YOUR_COSUMERR_KEY';
  String mConsumerSecret = 'ADD_YOUR_COSUMERR_SECRET';

  String mUserToken = '';
  String mUserSecret = '';
  String mScreenName = '';
}

mixin UserModel on ConnectedModel {
  User currentUser;
  UserStatus _result = UserStatus.notLogged;



  UserStatus get result => _result;

  Future<Null> login() async {
    var twitterLogin = new TwitterLogin(
      consumerKey: mConsumerKey,
      consumerSecret: mConsumerSecret,
    );
    final TwitterLoginResult result = await twitterLogin.authorize();
    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        var session = result.session;
        print('${session.username}');
        mUserToken = session.token;
        mUserSecret = session.secret;
        mScreenName = session.username;
        currentUser = User(
            name: session.username,
            screenName: session.username,
            imageUrl:
                'https://twitter.com/${session.username}/profile_image?size=original');
        _getScreenName();
        _getBanner();
        _result = UserStatus.logged;
        break;
      case TwitterLoginStatus.cancelledByUser:
        print('cancelledByUser');
        break;
      case TwitterLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  void _getScreenName() async {
    final String url = 'account/verify_credentials.json';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    currentUser.name = res['name'];
  }

  Future<Null> _getBanner() async {
    final String url =
        'users/profile_banner.json?screen_name=${currentUser.screenName}';
    Twitter twitter =
        new Twitter(mConsumerKey, mConsumerSecret, mUserToken, mUserSecret);
    var response = await twitter.request("GET", url);
    var res = json.decode(response.body);
    print('${res.toString()}  the screen name is here ');
    currentUser.banner = res['sizes']['web_retina']['url'];
  }


}
