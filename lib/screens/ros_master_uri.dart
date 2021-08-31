import 'package:dartros/dartros.dart';
import 'package:flutter/material.dart';
import 'package:dartx/dartx.dart';
import 'package:std_msgs/msgs.dart';
import 'package:sensor_msgs/msgs.dart';

class RosStreamer extends StatefulWidget {
  const RosStreamer({Key? key}) : super(key: key);

  @override
  _RosStreamerState createState() => _RosStreamerState();
}

class _RosStreamerState extends State<RosStreamer> {
  late NodeHandle nh;
  late Publisher imu_pub;

  @override
  void initState() async {
    super.initState();
    nh = await initNode("Hey", []);

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
          onPressed: () {
            print("Publish button pressed");
            final imu_msg = StringMessage(data: "Hi!!");
            imu_pub.publish(imu_msg);
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
