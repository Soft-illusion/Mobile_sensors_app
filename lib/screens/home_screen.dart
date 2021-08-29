import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:mobile_sensors/screens/camera.dart';
import 'package:mobile_sensors/screens/imu.dart';
// import 'package:mobile_sensors/screens/ros_master_uri.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Text(
                'Use phone a sensor on your robot.',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.green.withOpacity(0.7),
                ),
              ),
            ),
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
                        return IMU();
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
                        print("Camera clicked");
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
