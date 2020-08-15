import 'post.dart';

class User {
  String username;
  final String uid;
  String name;
  String avatarUrl;
  bool hasStory;
  String email;
  String phone;
  String bio;
  List<dynamic> followers; //list of uids
  List<dynamic> following; //list of uids
  List<Post> posts;

  User({
    this.username,
    this.avatarUrl,
    this.name,
    this.hasStory,
    this.uid,
    this.bio,
    this.followers,
    this.following,
    this.posts,
    this.email,
    this.phone,
  });

  factory User.fromMap(Map<String, dynamic> map) => User(
        username: map["username"] == null ? null : '${map["username"]}',
        name: map["name"] == null ? '' : '${map["name"]}',
        uid: map["uid"] == null ? null : '${map["uid"]}',
        hasStory: map["hasStory"] == null ? false : map["hasStory"],
        avatarUrl: map["avatarUrl"] == null ? null : '${map["avatarUrl"]}',
        bio: map["bio"] == null ? '' : '${map["bio"]}',
        email: map["email"] == null ? '' : '${map["email"]}',
        phone: map["phone"] == null ? '' : '${map["phone"]}',
        followers: map["followers"] == null ? [] : map["followers"],
        following: map["following"] == null ? [] : map["following"],
        posts: map["posts"] == null
            ? []
            : List.generate(
                map["posts"].length,
                (index) => Post.fromMap(
                  map['posts'][index],
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "uid": uid == null ? null : uid,
        "hasStory": hasStory == null ? null : hasStory,
        "bio": bio == null ? null : bio,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "followers": followers == [] ? null : followers,
        "following": following == [] ? null : following,
        "posts": posts == []
            ? null
            : List.generate(
                posts.length,
                (index) => posts[index].toMap(),
              ),
      };
}
