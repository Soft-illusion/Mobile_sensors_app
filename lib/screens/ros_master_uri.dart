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
  String IpAddressRos = '192.168.0.100';
  String RosPort = '11311'; 
  bool connected = false;

  @override
  void initState() {
    super.initState();
    
  }

  void init_ros() async {
    nh = await initNode("Hey", [], rosMasterUri: 'http://'+IpAddressRos+':'+RosPort);
    imu_pub = nh.advertise<StringMessage>("/imu/raw", StringMessage.$prototype);
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
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: connected? Colors.green:Colors.red, // not functional as this gets color when it loads. Need dynamic reconfiguration.
                          ) , 
                    onPressed: () async{
                      print(connected);
                      final imu_msg = StringMessage(data: "Hi!!");
                      for (int i=0;i<10;i++){
                        print("Publish button pressed");
                        imu_pub.publish(imu_msg,1);
                        await Future.delayed(2.seconds);
                      }
                    },
                    child: Text(
                      "Press to Publish",
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
