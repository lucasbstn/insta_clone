import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';

class Avatar extends StatelessWidget {
  final User user;

  const Avatar({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipOval(
        child: Image(
          image: CacheImage(
            user.avatarUrl,
          ),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.all(
        user.hasStory ? 2.0 : 0.0,
      ), // border width
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.yellow[400],
            Colors.purpleAccent.withBlue(200),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ), // border color
        shape: BoxShape.circle,
      ),
    );
  }
}
