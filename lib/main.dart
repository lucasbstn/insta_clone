import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/camera_controller.dart';
import 'controllers/user_controller.dart';
import 'views/login.dart';
import 'views/profile.dart';
import 'views/search.dart';
import 'views/home.dart';
import 'widgets/add.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  final FirebaseUser user;

  const MyApp(this.user);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
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
      home: GetBuilder<UserController>(
        init: UserController(user),
        builder: (controller) {
          Get.put(user);
          if (controller.firebaseUser == null) {
            return Login();
          } else {
            return Wrapper();
          }
        },
      ),
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
    camerasInit();
  }

  Future camerasInit() async {
    CameraControllerX controller = Get.put(CameraControllerX());
    controller.cameras = await availableCameras();
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
