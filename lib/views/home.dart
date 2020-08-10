import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/models/user.dart';
import 'package:insta_clone/widgets/avatar.dart';
import 'package:insta_clone/widgets/feed_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        actionsIconTheme: Theme.of(context).appBarTheme.iconTheme,
        textTheme: Theme.of(context).appBarTheme.textTheme,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: () => null,
        ),
        title: Text(
          'Instagram',
          style: GoogleFonts.pacifico(color:Colors.black),
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
              'alinaCaprioara',
              'https://i.pravatar.cc/301',
              true,
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
              'lucasbstn',
              'https://i.pravatar.cc/306',
              true,
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
              'antoine',
              'https://i.pravatar.cc/309',
              false,
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
        itemExtent: 80,
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Avatar(
            user: User(
              'lucasbstn',
              'https://i.pravatar.cc/301',
              true,
            ),
          ),
          Avatar(
            user: User(
              'alinaCaprioara',
              'https://i.pravatar.cc/302',
              false,
            ),
          ),
          Avatar(
            user: User(
              'antoinebstn',
              'https://i.pravatar.cc/303',
              true,
            ),
          ),
          Avatar(
            user: User(
              'michaelpilot',
              'https://i.pravatar.cc/304',
              true,
            ),
          ),
          Avatar(
            user: User(
              'jeanPoirot',
              'https://i.pravatar.cc/305',
              true,
            ),
          ),
          Avatar(
            user: User(
              'NFOe',
              'https://i.pravatar.cc/306',
              true,
            ),
          ),
        ],
      ),
    );
  }
}
