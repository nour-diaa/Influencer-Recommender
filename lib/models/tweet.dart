class Tweet {
  String created_at;
  String id_str;
  List<String> urls;
  List<String> hashtags;
  List<String> user_mentions;
  String text;
  int retweet_count;
  int favourites_count;
  String name;
  String profile_image_url;
  String profile_background_image_url_https;
  String location;
  int followers_count;
  String description;
  bool verified;
  String screen_name;

  Tweet({
      this.created_at,
      this.id_str,
      this.urls,
      this.hashtags,
      this.user_mentions,
      this.text,
      this.retweet_count,
    this.favourites_count,
      this.name,
      this.profile_image_url,
      this.profile_background_image_url_https,
      this.location,
      this.followers_count,
      this.description,
      this.verified,
      this.screen_name});

  Tweet.fromJson(Map<String, dynamic> json){
    this.created_at=  json['created_at'].toString() ?? '0000';
    this.id_str= json["id_str"] ?? '1111';
    this.text= json["full_text"] ?? 'empty tweet';
    this.retweet_count= json["retweet_count"] ?? 0;
    this.favourites_count= json["favorite_count"] ?? 0;
    this.name= json["user"]["name"] ?? 'no name';
    this.profile_image_url= json["user"]["profile_image_url"] ?? 'no profile image';
    this.profile_background_image_url_https= json["user"][" profile_background_image_url_https"] ?? 'no background';
    this.location= json["user"]["location"] ?? 'no location';
    this.followers_count= json["user"]["followers_count"] ?? 0;
    this.description= json["user"]["description"] ?? 'no description';
    this.verified= json["user"]["verified"] ?? false;
    this.screen_name= json["user"]["screen_name"] ?? 'no screen name';
  }
}
