import 'dart:io';

import 'package:cache_image/cache_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/controllers/user_controller.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future<File> getImage() async {
    File pickedFile =
        File((await ImagePicker().getImage(source: ImageSource.gallery)).path);

    return pickedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        title: Text('Edit Profile'),
        actions: [
          IconButton(
              icon: Icon(Icons.check, color: Colors.blue),
              onPressed: () {
                UserController userController = UserController.to;
                userController.updateUser(userController.user);
                Get.back();
              }),
        ],
      ),
      body: GetBuilder<UserController>(
        init: Get.find<UserController>(),
        builder: (userController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.15,
                            width: Get.height * 0.15,
                            child: CircleAvatar(
                              backgroundImage:
                                  CacheImage(userController.user.avatarUrl),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'Change profile photo',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        File file = await getImage();
                        FirebaseStorage.instance
                            .ref()
                            .child(userController.user.uid)
                            .putFile(file)
                            .onComplete
                            .then(
                          (value) async {
                            userController.user.avatarUrl =
                                await value.ref.getDownloadURL();
                            userController.updateUser(userController.user);
                          },
                        );
                      },
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: userController.user.name,
                          onChanged: (value) {
                            userController.user.name = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        TextFormField(
                          initialValue: userController.user.username,
                          onChanged: (value) {
                            userController.user.username = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Website',
                          ),
                        ),
                        TextFormField(
                          initialValue: userController.user.bio,
                          onChanged: (value) {
                            userController.user.bio = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'Bio',
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email address',
                          ),
                          initialValue: userController.user.email,
                          onChanged: (value) {
                            userController.user.email = value;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                          initialValue: userController.user.phone,
                          onChanged: (value) {
                            userController.user.phone = value;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
