import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';
import 'package:insta_clone/widgets/profile_button.dart';

import 'edit_profile.dart';

class Profile extends StatelessWidget {
  final String uid;

  const Profile({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            User user = User.fromMap(snapshot.data.data);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  user.username,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              endDrawer: Drawer(
                child: Column(
                  children: [
                    Spacer(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        UserController.to.signOut();
                        FirebaseAuth.instance.signOut();
                      }, //TODO switch to settings
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SignedInUserAvatar(user: user),
                              Column(
                                children: [
                                  Text(
                                    '${user.posts.length}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Posts'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${user.followers.length}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Followers'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${user.following.length}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Following'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${user.name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${user.bio}',
                            ),
                          ),
                          GetBuilder<UserController>(
                            builder: (userController) {
                              if (user.uid == userController.user.uid) {
                                return ProfileButton(
                                  label: 'Edit Profile',
                                  color: Colors.white,
                                  onClick: () => Get.to(
                                    EditProfile(),
                                  ),
                                );
                              } else if (userController.user.followers
                                      .contains(user.uid) &&
                                  !userController.user.following
                                      .contains(user.uid)) {
                                return ProfileButton(
                                  label: 'Follow back',
                                  color: Colors.blue,
                                  onClick: () {
                                    //update signed in user's following
                                    userController.user.following.add(user.uid);
                                    userController
                                        .updateUser(userController.user);
                                    //update searched user's followers
                                    user.followers.add(userController.user.uid);
                                    userController.updateUser(user);
                                  },
                                );
                              } else if (userController.user.following
                                  .contains(user.uid)) {
                                return ProfileButton(
                                  label: 'Unfollow',
                                  color: Colors.white,
                                  onClick: () {
                                    //update signed in user's following
                                    userController.user.following
                                        .remove(user.uid);
                                    userController
                                        .updateUser(userController.user);
                                    //update searched user's followers
                                    user.followers
                                        .remove(userController.user.uid);
                                    userController.updateUser(user);
                                  },
                                );
                              } else {
                                return ProfileButton(
                                  label: 'Follow',
                                  color: Colors.blue,
                                  onClick: () {
                                    //update signed in user's following
                                    userController.user.following.add(user.uid);
                                    userController
                                        .updateUser(userController.user);
                                    //update searched user's followers
                                    user.followers.add(userController.user.uid);
                                    userController.updateUser(user);
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            child: TabBar(
                              indicatorColor: Colors.black,
                              tabs: [
                                Icon(MaterialCommunityIcons.grid),
                                Icon(Entypo.clipboard),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: TabBarView(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: List.generate(
                                      user.posts.length,
                                      (index) => Container(
                                        height: Get.height / 5,
                                        width: Get.width / 3 - 4,
                                        child: Image.network(
                                          user.posts[index].imgUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
