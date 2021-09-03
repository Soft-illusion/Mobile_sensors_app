import 'package:dartros/dartros.dart';
import 'package:flutter/material.dart';
import 'package:dartx/dartx.dart';
import 'package:std_msgs/msgs.dart';
import 'package:sensor_msgs/msgs.dart';
 import 'dart:io';

class RosStreamer extends StatefulWidget {
  const RosStreamer({Key? key}) : super(key: key);

  @override
  _RosStreamerState createState() => _RosStreamerState();
}

class _RosStreamerState extends State<RosStreamer> {
  late NodeHandle nh;
  late Publisher imu_pub;

  @override
  void initState() {
    super.initState();
    init_ros();
  }

  void init_ros() async {
    nh = await initNode("Hey", [], rosMasterUri: "http://192.168.0.107:11311");
    imu_pub = nh.advertise<StringMessage>("/imu/raw", StringMessage.$prototype);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ROS Streamer"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            final imu_msg = StringMessage(data: "Hi!!");
            for (int i=0;i<10;i++){
              print("Publish button pressed");
              imu_pub.publish(imu_msg,1);
              await Future.delayed(2.seconds);
            }
            // sleep(const Duration(data: RosTime(secs: 1)));
          },
          child: Text(
            "Press to Publish",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
