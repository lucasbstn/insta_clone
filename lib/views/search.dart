import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          decoration: InputDecoration(hintText: 'Search'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_overscan),
            onPressed: () => null,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Wrap(
          runSpacing: 4.0,
          spacing: 4.0,
          alignment: WrapAlignment.start,
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
        ),
      ),
    );
  }
}
