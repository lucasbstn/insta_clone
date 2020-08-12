import 'package:flutter/material.dart';
import 'package:insta_clone/models/user.dart';

import 'avatar.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    Key key,
    @required this.size,
    @required this.user,
    @required this.isLiked,
    @required this.numberLikes,
    @required this.numberComments,
    @required this.description,
    @required this.hashtags,
    @required this.timestamp,
    @required this.imgUrl,
  }) : super(key: key);

  final Size size;
  final bool isLiked;
  final int numberLikes;
  final int numberComments;
  final String description;
  final String hashtags;
  final int timestamp;
  final String imgUrl;
  final User user;

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
              onTap: () => null, //TODO - route to profile
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
              widget.imgUrl,
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
                          icon: Icon(widget.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: () => null,
                        ),
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed: () => null,
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
                '${widget.numberLikes} likes',
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
                        text: widget.description,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' ' + widget.hashtags,
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
                onTap: () => null, //route to detailed post
                child: Text(
                  'View all ${widget.numberComments} comments',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Text(
                '${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.timestamp)).inHours} hours ago',
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
