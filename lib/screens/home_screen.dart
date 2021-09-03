import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:mobile_sensors/screens/camera.dart';
import 'package:mobile_sensors/screens/imu.dart';
import 'package:mobile_sensors/screens/ros_master_uri.dart';
import 'package:mobile_sensors/screens/gps.dart';


class Homescreen extends StatefulWidget {
  // const Homescreen({Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  Homescreen(this.cameras);
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Phone as a sensor for robot.',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown,
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
                  child: ElevatedButton(
                    onPressed: () {
                      print("IMU clicked");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return IMUScreen();
                      }));
                    },
                    child: Text(
                      'IMU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print("GPS clicked");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return GPS();
                      }));
                    },
                    child: Text(
                      'GPS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print("Camera clicked");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return Camera(widget.cameras);
                            }));
                      },
                      child: Text(
                        'Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print("Stream data clicked");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RosStreamer();
                      }));
                    },
                    child: Text(
                      'Stream Data to ROS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
