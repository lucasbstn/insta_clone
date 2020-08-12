import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';

import 'edit_profile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userController.user.username,
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
                userController.signOut();
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
                      Stack(
                        children: [
                          SizedBox(
                            height: Get.height * 0.13,
                            width: Get.height * 0.13,
                            child: Avatar(
                              user: userController.user,
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
                      ),
                      Column(
                        children: [
                          Text(
                            '${userController.user.posts.length}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Posts'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${userController.user.followers.length}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Followers'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${userController.user.following.length}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Following'),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${userController.user.name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${userController.user.bio}',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: SizedBox(
                        width: Get.width * 0.9,
                        height: 30,
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text('Edit Profile'),
                          onPressed: () => Get.to(
                            EditProfile(),
                          ),
                        ),
                      ),
                    ),
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
                            alignment: WrapAlignment.center,
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1006',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1007',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1015',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1014',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1013',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1012',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1011',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1009',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height: Get.height / 5,
                                width: Get.width / 3 - 4,
                                child: Image.network(
                                  'https://picsum.photos/1010',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
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
}
