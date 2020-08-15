import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/user_controller.dart';
import 'package:insta_clone/models/post.dart';
import 'package:insta_clone/widgets/avatar.dart';

class NewPost extends StatefulWidget {
  final String path;

  NewPost({Key key, this.path}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String description = '';
  final List<String> cities = [
    'Molsheim',
    'Obernai',
    'Mutzig',
    'Avolsheim',
    'Dorlisheim',
    'Search'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Post',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              UserController userController = UserController.to;
              String url;
              int timestamp = DateTime.now().millisecondsSinceEpoch;
              List<String> hashtags = description
                  .split(' ')
                  .where(
                    (element) => element.startsWith('#'),
                  )
                  .toList();
              FirebaseStorage.instance
                  .ref()
                  .child('$timestamp')
                  .putFile(
                    File(widget.path),
                  )
                  .events
                  .listen(
                (event) async {
                  if (event.type == StorageTaskEventType.success) {
                    url = await event.snapshot.ref.getDownloadURL();
                    userController.user.posts.add(
                      Post(
                        description: description,
                        imgUrl: url,
                        timestamp: timestamp,
                        hashtags: hashtags,
                      ),
                    );
                    userController.updateUser(userController.user);
                    Get.back();
                  }
                },
              );
            },
            child: Text(
              'Share',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: Avatar(
                      user: UserController.to.user,
                    ),
                  ),
                  SizedBox(
                    width: Get.width - 150,
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a caption...',
                      ),
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    child: Image.file(
                      File(widget.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1.3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tag people'),
              ),
              Divider(thickness: 1.3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add location'),
              ),
              Divider(thickness: 1.3),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  height: 25,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: cities
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.grey[300],
                              ),
                              child: Text(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Divider(thickness: 1.3),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Also post to'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Facebook'),
                  Switch(
                    value: false,
                    onChanged: (value) => null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Twitter'),
                  Switch(
                    value: false,
                    onChanged: (value) => null,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tumblr'),
                  Switch(
                    value: false,
                    onChanged: (value) => null,
                  ),
                ],
              ),
              Divider(thickness: 1.3),
            ],
          ),
        ),
      ),
    );
  }
}
