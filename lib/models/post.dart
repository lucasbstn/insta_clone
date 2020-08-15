class Post {
  List<dynamic> likedBy; //list uid
  List<dynamic> comments;
  String description;
  List<dynamic> hashtags;
  int timestamp;
  String imgUrl;

  Post({
    this.likedBy,
    this.comments,
    this.description,
    this.hashtags,
    this.timestamp,
    this.imgUrl,
  });

  factory Post.fromMap(Map<String, dynamic> map) => Post(
        likedBy: map["likedBy"] == null ? [] : map["likedBy"],
        comments: map["comments"] == null ? [] : map["comments"],
        description:
            map["description"] == null ? null : '${map["description"]}',
        hashtags: map["hashtags"] == null ? [] : map["hashtags"],
        timestamp: map["timestamp"] == null ? null : map["timestamp"],
        imgUrl: map["imgUrl"] == null ? null : '${map["imgUrl"]}',
      );

  Map<String, dynamic> toMap() => {
        "likedBy": likedBy == null ? null : likedBy,
        "comments": comments == null ? null : comments,
        "description": description == null ? null : description,
        "hashtags": hashtags == null ? null : hashtags,
        "timestamp": timestamp == null ? null : timestamp,
        "imgUrl": imgUrl == null ? null : imgUrl,
      };
}
