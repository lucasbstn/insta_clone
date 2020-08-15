import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/user.dart';

import 'avatar.dart';

class Stories extends StatelessWidget {
  const Stories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return GetBuilder<UserController>(builder: (userController) {
              List<User> following = List();
              snapshot.data.documents
                  .where(
                (element) =>
                    userController.user.following.contains(
                      element.data['uid'],
                    ) &&
                    element.data['hasStory'],
              )
                  .forEach(
                (user) {
                  following.add(
                    User.fromMap(user.data),
                  );
                },
              );
              if (following.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userController.user.following.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Avatar(user: following[index]),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            });
          }
        },
      ),
    );
  }
}
