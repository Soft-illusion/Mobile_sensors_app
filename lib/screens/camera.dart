import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class Camera extends StatefulWidget {
  List<CameraDescription> cameras = [];

  Camera(this.cameras);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('No cameras available'),
      ),
    );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raw Camera Data'),
      ),
      body: MaterialApp(
        home: CameraPreview(controller),
        ),
      );
  }
}