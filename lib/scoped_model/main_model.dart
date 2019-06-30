import 'package:scoped_model/scoped_model.dart';

import 'categories_model.dart';
import 'user_model.dart';
import 'influencer_model.dart';
import 'tweet_model.dart';

class MainModel extends Model
    with
        CategoriesModel,
        ConnectedModel,
        UserModel,
        InfluencerModel,
        TweetModel {}
