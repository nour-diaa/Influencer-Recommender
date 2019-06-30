import 'package:flutter/material.dart';

import '../models/tweet.dart';

class TimelineTweet extends StatefulWidget {
  final Tweet tweet;

  TimelineTweet({this.tweet});

  @override
  _TimelineTweetState createState() => _TimelineTweetState();
}

class _TimelineTweetState extends State<TimelineTweet> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: new NetworkImage(widget.tweet.profile_image_url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.lightBlue,
                    width: 2.0,
                  ),
                ),
              ),

                /* CircleAvatar(
                  backgroundImage: NetworkImage(widget.tweet.profile_image_url),
                ),*/
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeaderRow(),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(widget.tweet.text),
                ),
                Divider(),
                buildControlsRow()
              ],
            ),
          ),

        ],
      ),
    );
  }

  Row buildControlsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(icon: Icon(Icons.comment), onPressed: null),
        IconButton(icon: Icon(Icons.repeat), onPressed: null),
        IconButton(icon: Icon(Icons.favorite_border), onPressed: null),
        IconButton(icon: Icon(Icons.share), onPressed: null),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildHeaderRow() {
    return Row(
      children: <Widget>[
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:8),
              Text(
                widget.tweet.name,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(widget.tweet.screen_name),
            ],
          ),
        ),
      ],
    );
  }
}
