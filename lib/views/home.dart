import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';
import 'package:insta_clone/widgets/feed_card.dart';

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
        shrinkWrap: true,
        children: [
          Stories(),
          Divider(
            thickness: 1.3,
          ),
          FeedCard(
            size: size,
            user: User(
              username: 'alinaCaprioara',
              avatarUrl: 'https://i.pravatar.cc/302',
              hasStory: false,
            ),
            isLiked: true,
            numberComments: 1253,
            numberLikes: 199,
            description: 'My holiday with my girlfriend',
            hashtags: '#beach #perfect',
            timestamp: DateTime.now()
                .subtract(Duration(hours: 11))
                .millisecondsSinceEpoch,
            imgUrl: 'https://picsum.photos/500',
          ),
          FeedCard(
            size: size,
            user: User(
              username: 'alinaCaprioara',
              avatarUrl: 'https://i.pravatar.cc/302',
              hasStory: false,
            ),
            isLiked: true,
            numberComments: 1253,
            numberLikes: 199,
            description: 'My holiday with my girlfriend',
            hashtags: '#beach #perfect',
            timestamp: DateTime.now()
                .subtract(Duration(hours: 11))
                .millisecondsSinceEpoch,
            imgUrl: 'https://picsum.photos/502',
          ),
          FeedCard(
            size: size,
            user: User(
              username: 'alinaCaprioara',
              avatarUrl: 'https://i.pravatar.cc/302',
              hasStory: false,
            ),
            isLiked: true,
            numberComments: 1253,
            numberLikes: 199,
            description: 'My holiday with my girlfriend',
            hashtags: '#beach #perfect',
            timestamp: DateTime.now()
                .subtract(Duration(hours: 11))
                .millisecondsSinceEpoch,
            imgUrl: 'https://picsum.photos/501',
          ),
        ],
      ),
    );
  }
}

class Stories extends StatelessWidget {
  const Stories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Avatar(
              user: User(
                username: 'alinaCaprioara',
                avatarUrl: 'https://i.pravatar.cc/302',
                hasStory: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Avatar(
              user: User(
                username: 'alinaCaprioara',
                avatarUrl: 'https://i.pravatar.cc/303',
                hasStory: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Avatar(
              user: User(
                username: 'alinaCaprioara',
                avatarUrl: 'https://i.pravatar.cc/306',
                hasStory: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Avatar(
              user: User(
                username: 'alinaCaprioara',
                avatarUrl: 'https://i.pravatar.cc/305',
                hasStory: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Avatar(
              user: User(
                username: 'alinaCaprioara',
                avatarUrl: 'https://i.pravatar.cc/304',
                hasStory: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
