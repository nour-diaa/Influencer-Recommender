import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/main_model.dart';

class InfluencerListItem extends StatefulWidget {
  final String name;
  final String description;
  final String image;

  InfluencerListItem(
      {@required this.name, @required this.description, @required this.image});

  @override
  _InfluencerListItemState createState() => _InfluencerListItemState();
}

class _InfluencerListItemState extends State<InfluencerListItem> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 110,
      padding: _width < 600
          ? EdgeInsets.only(left: 30, right: 20)
          : EdgeInsets.only(left: 70, right: 60),
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Card(
            elevation: 10,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 60),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AutoSizeText(
                        widget.name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.description,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return IconButton(
                      icon: Icon(
                        model.friends.contains(widget.description)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        // testing follow feature
                        // TODO implement follow/ unfollow model.unFollow('trikaofficial');

                        setState(() {
                          if (model.friends.contains(widget.description)) {
                            model.unFollow(widget.description);
                            model.removeFriend(widget.description);
                          } else {
                            model.follow(widget.description);
                            model.addFriend(widget.description);
                          }
                        });
                      });
                }),
                SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: -15,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 3, color: Theme.of(context).primaryColorDark)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.image,
                    width: 60,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
