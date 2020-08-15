import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';

import 'package:insta_clone/widgets/feed_card.dart';
import 'package:insta_clone/widgets/stories.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MaterialCommunityIcons.instagram),
          onPressed: () => null,
        ),
        title: Text(
          'Instagram',
          style: TextStyle(fontFamily: 'Billabong', fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => null,
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: SignedInUserAvatar(user: UserController.to.user),
                ),
                Stories(),
              ],
            ),
          ),
          Divider(
            thickness: 1.3,
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GetBuilder<UserController>(
                  builder: (userController) {
                    List<User> users = List();
                    snapshot.data.documents
                        .where(
                      (user) => userController.user.following.contains(
                        user.data['uid'],
                      ),
                    )
                        .forEach(
                      (element) {
                        users.add(User.fromMap(element.data));
                      },
                    );

                    List<List<dynamic>> posts = List();
                    users.forEach(
                      (user) {
                        user.posts.forEach((post) {
                          posts.add([user, post]);
                        });
                      },
                    );
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return FeedCard(
                          size: size,
                          post: posts[index][1],
                          user: posts[index][0],
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
