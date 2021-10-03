import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sensor_msgs/msgs.dart';
import 'package:camera/camera.dart';



class Camera {
  List<CameraDescription> cameras = [];
  late CameraController controller;
  bool front = false;

  void get_camera(List<CameraDescription> cam){ 
    cameras = cam;
  }

  void get_controller(CameraController con){ 
    controller = con;
  }

  void stream(){
    if (cameras == null || cameras.length < 1) {
      print('No camera is found');
    } else {
      flip_cam();
    }
  }

  Future<void> startCamera() async{
    WidgetsFlutterBinding.ensureInitialized();
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error: $e.code\nError Message: $e.message');
    }
  }

  void flip_cam(){
    controller = new CameraController(
        cameras[front? 1:0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        // if (!mounted) {
        //   return;
        // }
      });
  }

  Scaffold create_UI(){
    late Scaffold UI;

    if (controller == null || !controller.value.isInitialized) {
      UI = Scaffold(
      appBar: AppBar(
        title: const Text('No cameras available'),
      ),
    );
    }
    else {
      UI = Scaffold(
      appBar: AppBar(
        title: const Text('Raw Camera Data'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Flip camera"),
            onPressed: () {
              front = !front;
              print(front);
              flip_cam();
            }
          )
        ],
      ),
      body: MaterialApp(
        home: CameraPreview(controller),
        ),
      );
    }
      
    return UI;
  }
}