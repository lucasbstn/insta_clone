import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/views/home.dart';

import 'views/search.dart';
import 'widgets/add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
        ),
      ),
      home: Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Icon> tabs = [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.add_box),
    Icon(Icons.favorite_border),
    Icon(Icons.person),
  ];

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 5,
    );

    _tabController.addListener(
      () async {
        if (_tabController.index == 2) {
          _tabController.animateTo(_tabController.previousIndex);
          Get.to(Add());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Home(),
          Search(),
          AddContainer(),
          Liked(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: TabBar(
          indicatorColor: Theme.of(context).appBarTheme.color,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}

class AddContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Liked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
