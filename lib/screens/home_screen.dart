import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:mobile_sensors/screens/camera.dart';
// import 'package:mobile_sensors/screens/imu.dart';
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
              padding: EdgeInsets.only(left: 20.0, right: 120.0, top: 30.0),
              child: Text('Choose a sensor',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      onPressed: () {
                        print("Camera clicked");
                      },
                      child: Container(
                        height: 60.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFA8D7C8),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          'Camera',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xE81616FF),
                            fontSize: 20.0,
                          ),

                        ),
                      ),
                    )

                ),

                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    onPressed: () {
                      print("IMU clicked");
                    },
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFA8D7C8),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        'IMU',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xE81616FF),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    onPressed: () {
                      print("Stream data clicked");
                    },
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFA8D7C8),
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        'Stream Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xE81616FF),
                          fontSize: 20.0,
                        ),
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