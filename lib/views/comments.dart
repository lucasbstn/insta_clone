import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatefulWidget {
  final Post post;
  final User user;

  const Comments({Key key, this.post, this.user}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        actions: [
          IconButton(icon: Icon(Icons.send), onPressed: () => null),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: widget.post.comments.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: Avatar(user: widget.user),
                    ),
                    title: RichText(
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
                    subtitle: Text(
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
                  );
                } else {
                  User user = User.fromMap(
                    snapshot.data.documents
                        .firstWhere((element) =>
                            element.documentID ==
                            widget.post.comments[index - 1]['uid'])
                        .data,
                  );
                  return ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: Avatar(user: user),
                    ),
                    title: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: user.username + ' ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: widget.post.comments[index - 1]['content'],
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      timeago.format(
                        DateTime.now().subtract(
                          DateTime.now().difference(
                            DateTime.fromMillisecondsSinceEpoch(
                              widget.post.comments[index - 1]['timestamp'],
                            ),
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.grey[700], fontSize: 9),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                child: Avatar(user: UserController.to.user),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: SizedBox(
                  width: Get.width - 140,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Comment as ${UserController.to.user.username}',
                    ),
                    controller: commentController,
                    focusNode: commentFocus,
                  ),
                ),
              ),
              Container(
                width: 70,
                child: FlatButton(
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    UserController userController = UserController.to;
                    widget.user.posts
                        .firstWhere(
                            (post) => post.timestamp == widget.post.timestamp)
                        .comments
                        .add(
                      {
                        'uid': userController.user.uid,
                        'content': commentController.text,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                      },
                    );
                    commentController.clear();
                    commentFocus.unfocus();
                    userController.updateUser(widget.user);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
