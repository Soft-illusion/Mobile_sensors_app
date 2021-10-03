import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:mobile_sensors/src/Imu_class.dart';

class IMUScreen extends StatefulWidget {
  const IMUScreen({Key? key}) : super(key: key);

  @override
  _IMUScreenState createState() => _IMUScreenState();
}

class _IMUScreenState extends State<IMUScreen> {
  IMU IMU_obj = new IMU();

  @override
  void initState() {
    super.initState();
    IMU_obj.list_subscriber();
    accelerometerEvents.listen((AccelerometerEvent event){
      setState(() {
        IMU_obj.update();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in IMU_obj.get_stream()) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IMU_obj.create_UI();
  }
}
