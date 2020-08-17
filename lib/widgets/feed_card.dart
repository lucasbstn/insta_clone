import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/views/comments.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/views/profile.dart';

import 'avatar.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    Key key,
    @required this.size,
    @required this.post,
    @required this.user,
  }) : super(key: key);

  final Size size;

  final User user;
  final Post post;
  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  @override
  Widget build(BuildContext context) {
    final TransformationController transformationController =
        TransformationController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.to(Profile(uid: widget.user.uid)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Avatar(
                        user: widget.user,
                      ),
                    ),
                  ),
                  Text(widget.user.username),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => null,
            ),
          ],
        ),
        InteractiveViewer(
          transformationController: transformationController,
          onInteractionEnd: (details) {
            setState(() {
              transformationController.toScene(Offset.zero);
            });
          },
          minScale: 0.1,
          maxScale: 4.0,
          child: Container(
            color: Colors.lightGreen,
            height: widget.size.height * 0.3,
            width: widget.size.width,
            child: Image.network(
              widget.post.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: widget.size.width / 2.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: widget.post.likedBy
                                  .contains(UserController.to.user.uid)
                              ? Icon(Icons.favorite, color: Colors.red)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            UserController userController = UserController.to;
                            if (widget.post.likedBy
                                .contains(UserController.to.user.uid)) {
                              widget.user.posts
                                  .firstWhere((post) =>
                                      post.timestamp == widget.post.timestamp)
                                  .likedBy
                                  .remove(userController.user.uid);
                            } else {
                              widget.user.posts
                                  .firstWhere((post) =>
                                      post.timestamp == widget.post.timestamp)
                                  .likedBy
                                  .add(userController.user.uid);
                            }
                            userController.updateUser(widget.user);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed: () => Get.to(
                            Comments(post: widget.post, user: widget.user),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => null,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark_border),
                    onPressed: () => null,
                  ),
                ],
              ),
              Text(
                '${widget.post.likedBy.length} likes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: widget.user.username + ' ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: widget.post.description,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' ' + widget.post.hashtags.join(' '),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(
                  Comments(post: widget.post, user: widget.user),
                ),
                child: Text(
                  'View all ${widget.post.comments.length} comments',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Text(
                timeago.format(
                  DateTime.now().subtract(
                    DateTime.now().difference(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.post.timestamp),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.grey[700], fontSize: 9),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
