import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_model/main_model.dart';
import '../widgets/background_container.dart';
import '../widgets/influencer_list_item.dart';
import '../widgets/influencers_search_field.dart';

import 'package:influencer_recommender/screens/auth.dart';
import 'package:influencer_recommender/screens/influncer_profile.dart';
import 'package:influencer_recommender/screens/profile.dart';

class RecommendationsListScreen extends StatefulWidget {
  @override
  _RecommendationsListScreenState createState() =>
      _RecommendationsListScreenState();
}

class _RecommendationsListScreenState extends State<RecommendationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Stack(
            children: <Widget>[
              BackgroundContainer(),
              FutureBuilder(
                  future: model.initInfluencers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ListView.builder(
                              itemCount: model.influencers.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: InfluencerListItem(
                                    name: model.influencers[index].name,
                                    description:
                                        model.influencers[index].screenName,
                                    image: model.influencers[index].imageUrl,
                                  ),
                                  onTap: () {
                                    print(model.influencers[index].name);
                                    model.selectInfluencer(index);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfluencerProfile()),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  })
            ],
          );
        },
      ),
    );
  }
}
