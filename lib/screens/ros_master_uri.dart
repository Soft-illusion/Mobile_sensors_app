import 'dart:async';

import 'package:dartros/dartros.dart';
import 'package:flutter/material.dart';
import 'package:dartx/dartx.dart';
import 'package:std_msgs/msgs.dart';
import 'package:geometry_msgs/msgs.dart';
import 'package:sensor_msgs/msgs.dart' as ros_msg;
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:mobile_sensors/src/Imu_class.dart';
import 'package:mobile_sensors/src/gps_class.dart';
import 'package:camera/camera.dart';


class RosStreamer extends StatefulWidget {
  List<CameraDescription> cameras = [];
  RosStreamer(this.cameras);

  @override
  _RosStreamerState createState() => _RosStreamerState();
}

class _RosStreamerState extends State<RosStreamer> {
  IMU IMU_obj = new IMU();
  GPS GPS_obj = new GPS();

  late NodeHandle nh;
  late Publisher imu_pub;
  late Publisher imu_pub_mag;
  late Publisher gps_pub;
  late Publisher image_pub;
  late CameraController controller;
  bool front = false;


  String IpAddressRos = '192.168.0.100';
  String RosPort = '11311'; 
  bool connected = false;

  @override
  void initState() {
    super.initState();
    // Imu data publish
    IMU_obj.list_subscriber();
      accelerometerEvents.listen((AccelerometerEvent event){
      setState(() {
        IMU_obj.update();
        IMU_obj.convert_to_str();
      });
       if (connected){
          imu_pub.publish(IMU_obj.get_imu_message(),1);
          imu_pub_mag.publish(IMU_obj.get_mag_message(),1);
        }
    });
    // GPS data publishing
    GPS_obj.check_service_enabled();
    Geolocator.getPositionStream().listen(
    (Position location) {
      setState(() {
        GPS_obj.check_permission();
      });
      if (connected){
          gps_pub.publish(GPS_obj.get_gps_message(),1);

      }
    });
    // Camera data publishing
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      flip_cam();
    }
    // controller.startImageStream((CameraImage availableImage) {
    //     controller.stopImageStream();
    //     print(availableImage);
    //     ros_msg.Image Img = ros_msg.Image(header: null,
    //                                   height: availableImage.height,
    //                                   width: availableImage.width,
    //                                   encoding: availableImage.format.raw,
    //                                   step: 1024 * 4,
    //                                   data: List.generate(600 * 1024 * 4, (_) => 255));
    //   });
    
  }

  void flip_cam(){
    controller = new CameraController(
        widget.cameras[front? 1:0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
  }

  void dispose() {
    controller.dispose();
    for (StreamSubscription<dynamic> subscription in IMU_obj.get_stream()) {
      subscription.cancel();
    }
    super.dispose();
  }

  void init_ros() async {
    nh = await initNode("IMU_data", [], rosMasterUri: 'http://'+IpAddressRos+':'+RosPort);
    imu_pub = nh.advertise<ros_msg.Imu>("/imu/raw", ros_msg.Imu.$prototype);
    imu_pub_mag = nh.advertise<ros_msg.MagneticField>("/imu/mag", ros_msg.MagneticField.$prototype);
    gps_pub= nh.advertise<ros_msg.NavSatFix>("/gps", ros_msg.NavSatFix.$prototype);
    image_pub = nh.advertise<ros_msg.Image>("/image/raw", ros_msg.Image.$prototype);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ROS Streamer"),
      ),
 
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child:TextFormField(
                    initialValue: IpAddressRos,
                    onChanged: (String value){
                      IpAddressRos = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Roscore IP',
                    ),
                  )
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child:TextFormField(
                      initialValue: RosPort,
                      onChanged: (String port){
                        RosPort = port;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Port Number',
                    ),
                  )
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Colors.red,
                          ) , 
                    onPressed: () async{
                      try {
                        print('Port :' + RosPort);
                        print('IP :' + IpAddressRos);

                        connected = true;
                        // try catch not catching the non roscore IP
                        init_ros();
                      }
                      on Exception catch (_){
                        connected = false;
                      }
                    },
                    child: Text(
                      "Connect",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
            ),
          ],
       ),
      ),
    );
  }
}
