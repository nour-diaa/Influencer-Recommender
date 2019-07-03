class Influencer {
  String name;
  String screenName;
  String imageUrl;
  double rate;
  String location;
  String gender;
  String banner;

  int followers = 0;
  int likes = 0;
  int tweets = 0;

  Influencer({this.name, this.screenName, this.imageUrl,this.banner,this.followers,this.likes,this.tweets});

  Influencer.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.screenName = json['screen_name'];
    this.imageUrl =
        'https://twitter.com/${this.screenName}/profile_image?size=original';
    this.rate = json['rate'] / 100;
    this.location = json['location'];
    this.gender = json['gender'];

  }




}
