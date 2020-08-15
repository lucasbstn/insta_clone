import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/views/profile.dart';
import 'package:insta_clone/widgets/avatar.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchQuery = '';
  int _stackIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _stackIndex == 0
            ? Icon(Icons.search)
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () => setState(() => _stackIndex = 0),
              ),
        title: TextField(
          onTap: () => setState(() => _stackIndex = 1),
          decoration: InputDecoration(hintText: 'Search'),
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
        ),
        actions: [
          _stackIndex == 0
              ? IconButton(
                  icon: Icon(Icons.settings_overscan),
                  onPressed: () => null,
                )
              : Container(),
        ],
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: IndexedStack(
              index: _stackIndex,
              children: [
                SearchViewTrending(),
                SizedBox(
                  height: Get.height - Scaffold.of(context).appBarMaxHeight,
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .where('username', isGreaterThanOrEqualTo: _searchQuery)
                        .where('username',
                            isLessThanOrEqualTo: _searchQuery + '\uf8ff')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            User user = User.fromMap(
                                snapshot.data.documents[index].data);
                            return ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                child: Avatar(user: user),
                              ),
                              title: Text(user.username),
                              onTap: () => Get.to(
                                Profile(uid: user.uid),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchViewTrending extends StatelessWidget {
  const SearchViewTrending({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4.0,
      spacing: 4.0,
      alignment: WrapAlignment.center,
      children: [
        Container(
          height: Get.height / 2,
          width: Get.width,
          child: Image.network(
            'https://picsum.photos/1005',
            fit: BoxFit.cover,
          ),
        ),
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
            'https://picsum.photos/1008',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: Get.height / 3.5,
          width: Get.width / 2 - 4,
          child: Image.network(
            'https://picsum.photos/1009',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: Get.height / 3.5,
          width: Get.width / 2 - 4,
          child: Image.network(
            'https://picsum.photos/1010',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
