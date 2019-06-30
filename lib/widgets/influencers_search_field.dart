import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/influencer.dart';
import '../scoped_model/main_model.dart';

class InfluencersSearchField extends StatefulWidget {
  @override
  _InfluencersSearchFieldState createState() => _InfluencersSearchFieldState();
}

class _InfluencersSearchFieldState extends State<InfluencersSearchField> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Influencer>> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return searchTextField = AutoCompleteTextField<Influencer>(
          key: key,
          clearOnSubmit: false,
          suggestions: model.influencers,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search for influencers'),
          itemFilter: (influencer, query) {
            return influencer.name
                .toLowerCase()
                .startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.name.compareTo(b.name);
          },
          itemSubmitted: (influencer) {
            setState(() {
              searchTextField.textField.controller.text = influencer.name;
            });
          },
          itemBuilder: (BuildContext context, Influencer influencer) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(influencer.imageUrl),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(influencer.name, style: TextStyle(fontSize: 18),),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
