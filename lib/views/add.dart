import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/controllers/camera_controller.dart';
import 'package:path_provider/path_provider.dart';

import 'new_post.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  CameraController controller;
  CameraControllerX controllerX;
  bool _isRecording = false;

  @override
  void initState() {
    controllerX = Get.find<CameraControllerX>();
    controller =
        CameraController(controllerX.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Video/Photo',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height / 2.5,
              width: Get.width,
              child: CameraPreview(controller),
            ),
            _isRecording ? LinearProgressIndicator() : Container(),
            GestureDetector(
              child: Container(
                height: Get.height / 2 - 85,
                child: Center(
                  child: Container(
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(
                      16.0,
                    ), // border width
                    decoration: BoxDecoration(
                      color: _isRecording
                          ? Colors.grey[700]
                          : Colors.grey[200], // border color
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              onPanStart: (d) async {
                String path = (await getTemporaryDirectory()).path +
                    '${DateTime.now().millisecondsSinceEpoch}.mp4';

                controller.startVideoRecording(path);
                setState(() => _isRecording = true);
              },
              onPanEnd: (d) {
                controller.stopVideoRecording();
                setState(() => _isRecording = false);
              },
              onTap: () async {
                String path = (await getTemporaryDirectory()).path +
                    '${DateTime.now().millisecondsSinceEpoch}.png';

                await controller.takePicture(path);
                Get.to(NewPost(path: path));
              },
            ),
          ],
        ),
      ),
    );
  }
}
