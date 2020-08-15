import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class SignedInUserAvatar extends StatelessWidget {
  const SignedInUserAvatar({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height * 0.13,
          width: Get.height * 0.13,
          child: Avatar(
            user: user,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 25,
            width: 25,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: ClipOval(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            padding: EdgeInsets.all(
              2.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
