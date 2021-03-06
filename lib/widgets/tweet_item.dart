import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main_model.dart';
import '../models/tweet.dart';

class TweetItem extends StatefulWidget {
  Tweet _tweet;

  TweetItem(this._tweet);

  @override
  _TweetItemState createState() => _TweetItemState();
}

class _TweetItemState extends State<TweetItem> {
  double _screenWidth;
  double _screenHeight;
  bool isLiked = false;
  bool isRetweet = false;
  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    return Container(
        width: _screenWidth * 0.8,
        margin: EdgeInsets.only(bottom: 18, left: 40, right: 10),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          elevation: 8,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 40, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    buildNameContainer(),
                    SizedBox(height: 4),
                    Text(
                      widget._tweet.screen_name,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        widget._tweet.text,
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(height: 15),
                    buildActionsRow(),
                    SizedBox(height: 5)
                  ],
                ),
              ),
              buildAvatar(),
            ],
          ),
        ));
  }

  Row buildActionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
            icon:
                Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.grey),
            onPressed: () {
              isChanged = true;
              MainModel model = ScopedModel.of<MainModel>(context);
              if (isLiked) {
                model.unLike(widget._tweet.id_str);
                setState(() {
                  isLiked = false;
                });
              } else {
                model.like(widget._tweet.id_str);
                setState(() {
                  isLiked = true;
                });
              }
            }),
        SizedBox(width: 4),
        Text('${getLikeNum(widget._tweet.favourites_count)}',
            style: TextStyle(color: Colors.grey)),
        SizedBox(width: 8),
        IconButton(
            icon: Icon(Icons.repeat,
                color: isRetweet ? Colors.green : Colors.grey),
            onPressed: () {
              isChanged = true;
              MainModel model = ScopedModel.of<MainModel>(context);
              if (isRetweet) {
                model.unRetweet(widget._tweet.id_str);
                setState(() {
                  isRetweet = false;
                });
              } else {
                model.retweet(widget._tweet.id_str);
                setState(() {
                  isRetweet = true;
                });
              }
            }),
        SizedBox(width: 4),
        Text(
            '${getRetweetNum(widget._tweet.retweet_count)}',
            style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  int getRetweetNum(int count){
    if(!isChanged)
      return count;
    if(isRetweet)
      return ++count;
    else
      return count;
  }

  int getLikeNum(int count){
    if(!isChanged)
      return count;
    if(isLiked)
      return ++count;
    else
      return count;
  }

  Widget buildNameContainer() {
    return Row(
      children: <Widget>[
        AutoSizeText(
          widget._tweet.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        widget._tweet.verified
            ? Icon(Icons.verified_user, color: Colors.blue)
            : Container()
      ],
    );
  }

  Positioned buildAvatar() {
    return Positioned(
      top: 20,
      left: -25,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightBlue, width: 2),
          image: DecorationImage(
              image: NetworkImage(
                  'https://twitter.com/${widget._tweet.screen_name}/profile_image?size=original'),
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
